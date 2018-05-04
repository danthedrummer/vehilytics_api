require 'rails_helper'

RSpec.describe 'Devices API', type: :request do
  
  describe 'GET /v1/devices' do
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    let(:valid_headers) { { 'X-User-Email' => user.email, 'X-User-Token' => user.authentication_token } }
    
    context 'when the user has an attached device' do
      before { 
        user.device = device
        get '/v1/devices', headers: valid_headers 
      }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns the device info' do
        expect(json).to eq(obj_to_json_hash(device.as_json(only: [:device_name, :email])))
      end
    end
  end
  
  describe 'POST /v1/devices' do
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    
    context 'when the attach request is valid' do
      before { 
        post '/v1/devices', params: { 'function'=>'attach', 'user_email'=>user.email, 
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
    
    context 'when the detach request is valid' do
      before { 
        user.device = device
        post '/v1/devices', params: { 'function'=>'detach', 'user_email'=>user.email, 
          'user_token'=>user.authentication_token, 'device_name'=>device.device_name }
      }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'should detach the device from the user' do
        expect(User.find_by_email(user.email).device).to eq(nil)
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
  
  # describe 'DELETE /v1/devices' do
  #   let!(:user) { create(:user) }
  #   let!(:device) { create(:device) }
  #   let(:valid_headers) { { 'X-User-Email' => user.email, 'X-User-Token' => user.authentication_token } }
  #   before {
  #     user.device = device
  #   }
    
  #   context 'when the request is valid' do
  #     before { delete '/v1/devices', headers: valid_headers }
      
  #     it 'returns a status code 200' do
  #       expect(response).to have_http_status(200)
  #     end
      
  #     it 'detaches the device from the user' do
  #       expect(user.device).to eq(nil)
  #     end
  #   end
  # end
end