require 'rails_helper'

RSpec.describe 'Device Sessions API', type: :request do
  
  describe 'GET /v1/device_sessions' do
    let!(:device) {  create(:device) }
    
    context 'when the request is valid' do
      before { get '/v1/device_sessions', headers: { 'X-Device-Email' => device.email, 
        'X-Device-Token' => device.authentication_token } }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the request is invalid' do
      before { get '/v1/device_sessions' }
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe 'POST /v1/device_sessions' do
    let!(:device) { build(:device) }
    
    context 'when the request is valid' do
      before {
        device.password = "password"
        device.password_confirmation = "password"
        device.save!
      }
      before { post '/v1/device_sessions', params: {email: device.email, password: "password" } }
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the authentication token for the device' do
        expect(json).to have_key('authentication_token')
      end
    end
    
    context 'when the request is invalid' do
      before {
        device.save!
      }
      before { post '/v1/device_sessions', params: { email: "something", password: "anything" } }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe 'DELETE /v1/device_sessions' do
    let!(:device) { create(:device) }
    let!(:original_token) { device.authentication_token }
    
    context 'when the request is valid' do
      before { delete '/v1/device_sessions', headers: {'X-Device-Email' => device.email,
        'X-Device-Token' => device.authentication_token } }
        
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'should reset the authentication token' do
        expect(Device.find_by_email(device.email)).not_to eq(original_token)
      end
    end
    
    context 'when the request is invalid' do
      before { delete '/v1/device_sessions' }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end