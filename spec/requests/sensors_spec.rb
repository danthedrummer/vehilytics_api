require 'rails_helper'

RSpec.describe 'Sensors API', type: :request do
  
  describe 'GET /v1/sensors' do
    let!(:sensors) { create_list(:sensor, 4) }
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    before { 
      user.sensors << sensors[0] << sensors[2]
      user.device = device
      device.sensors << sensors[1] << sensors[3]
    }
    
    context 'when a user requests reported sensors' do
      before { get '/v1/sensors', headers: {'X-User-Email' => user.email, 
        'X-User-Token' => user.authentication_token } }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all of the sensors reported by their device' do
        expected = {'sensors'=>obj_to_json_hash(user.device.sensors), 
          'warnings'=>[], 'errors'=>[]}
        expect(json).to eq(expected)
      end
    end
    
    context 'when a user requests their preferred sensors' do
      before { get '/v1/sensors', headers: {'X-User-Email' => user.email, 
        'X-User-Token' => user.authentication_token }, params:{'user_filter' => 'requested'} }
        
        it 'returns a status code 200' do
          expect(response).to have_http_status(200)
        end
        
        it 'returns all the sensors requested by the user' do
          expect(json).to eq(obj_to_json_hash(user.sensors))
        end
    end
    
    context 'when a device requests sensors' do
      before { get '/v1/sensors', headers: {'X-Device-Email' => device.email, 
        'X-Device-Token' => device.authentication_token } }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns all of the sensors requested by it\'s user' do
        expect(json).to eq(obj_to_json_hash(device.user.sensors))
      end
    end
    
    context 'when all sensors are requested' do
      before { get '/v1/sensors' }
      
      it 'returns a list of every sensor' do
        expect(json).to eq(obj_to_json_hash(sensors))
      end
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the authentication is invalid' do
      before { get '/v1/sensors', headers: { 'X-User-Email' => user.email,
        'X-User-Token' => device.authentication_token } }
        
        it 'returns a status code 401' do
          expect(response).to have_http_status(401)
        end
    end
  end
  
  describe 'POST /v1/sensors' do
    let!(:sensors) { create_list(:sensor, 4) }
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    let(:valid_headers) { { 'user_email'=>user.email, 'user_token'=>user.authentication_token } }
    before { 
      user.device = device
    }
    
    context 'when request is valid' do
      before { post '/v1/sensors', params: {'sensors'=>[sensors[0].shortname, sensors[2].shortname], 
        'user_email'=>user.email, 'user_token'=>user.authentication_token} }
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
      
      it 'should update the user sensor list' do
        expected = [sensors[0], sensors[2]]
        expect(User.find_by_email(user.email).sensors).to eq(expected)
      end
    end
    
    context 'when the params are invalid' do
      before { post '/v1/sensors', params: {  'user_email'=>user.email, 
        'user_token'=>user.authentication_token } }
        
        it 'returns a status code 400' do
          expect(response).to have_http_status(400)
        end
    end
    
    context 'when the headers are invalid' do
      before { post '/v1/sensors', params: { 'sensors'=>[sensors[0].shortname, sensors[2].shortname] } }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end