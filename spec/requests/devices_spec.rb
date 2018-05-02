require 'rails_helper'

RSpec.describe 'Devices API', type: :request do
  
  describe 'POST /v1/devices' do
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    
    context 'when the request is valid' do
      before { 
        post '/v1/devices', params: { 'user_email'=>user.email, 
          'user_token'=>user.authentication_token, 'device_name'=>device.device_name }
      }
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the device information' do
        expect(json['email']).to eq(device.email) 
        expect(json['device_name']).to eq(device.device_name)
      end
    end
    
    context 'when the request headers are invalid' do
      before { post '/v1/devices', params: { 'user_email'=>user.email } }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
    
    context 'when the request params are invalid' do
      before { post '/v1/devices', params: { 'user_email'=>user.email, 
          'user_token'=>user.authentication_token } }
      
      it 'returns a status code 400' do
        expect(response).to have_http_status(400)
      end
    end
    
  end
end