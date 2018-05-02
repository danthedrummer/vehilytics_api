require 'rails_helper'

RSpec.describe 'User Sessions API', type: :request do
  
  describe 'GET /v1/sessions' do
    let!(:user) {  create(:user) }
    
    context 'when the request is valid' do
      before { get '/v1/sessions', headers: { 'X-User-Email' => user.email, 
        'X-User-Token' => user.authentication_token } }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the request is invalid' do
      before { get '/v1/sessions' }
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe 'POST /v1/sessions' do
    let!(:user) { build(:user) }
    
    context 'when the request is valid' do
      before {
        user.password = "password"
        user.password_confirmation = "password"
        user.save!
      }
      before { post '/v1/sessions', params: {email: user.email, password: "password" } }
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the authentication token for the user' do
        expect(json).to have_key('authentication_token')
      end
    end
    
    context 'when the request is invalid' do
      before {
        user.save!
      }
      before { post '/v1/sessions', params: { email: "something", password: "anything" } }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe 'DELETE /v1/sessions' do
    let!(:user) { create(:user) }
    let!(:original_token) { user.authentication_token }
    
    context 'when the request is valid' do
      before { delete '/v1/sessions', headers: {'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token } }
        
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'should reset the authentication token' do
        expect(User.find_by_email(user.email)).not_to eq(original_token)
      end
    end
    
    context 'when the request is invalid' do
      before { delete '/v1/sessions' }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end