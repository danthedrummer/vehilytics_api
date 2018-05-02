require 'rails_helper'

RSpec.describe 'User Registrations API', type: :request do
  
  describe 'POST /users' do
    let!(:user) { create(:user) }
    let(:valid_attributes) { { user: { email: Faker::Internet.unique.email, 
      password: "password", password_confirmation: "password" } } }
    
    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }
      
      it 'returns authentication token for the new user' do
        expect(json).to have_key('token')
      end
      
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
    let(:duplicate_email) { { user: { email: user.email,
      password: "password", password_confirmation: "password" } } }
    
    context 'when the email is already registered' do
      before { post '/users', params: duplicate_email }
      
      it 'returns a validation failure message' do
        expect(response.body).to match(/Email address already registered./)
      end
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
      
    let(:missing_attribute) { { user: { email: Faker::Internet.unique.email, password: "password"} } }
    
    context 'when the request has missing attributes' do
      before { post '/users', params: missing_attribute }
      
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      
      it 'returns a validation failure message' do
        expect(response.body).to match(/The request must contain the user email, password, and password confirmation/)
      end
    end
    
  end
  
  
end