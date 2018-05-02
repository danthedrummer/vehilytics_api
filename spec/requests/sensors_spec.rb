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
    
    context 'when user requests sensors' do
      before { get '/v1/sensors', headers: {'X-User-Email' => user.email, 
        'X-User-Token' => user.authentication_token } }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all of the sensors reported by their device' do
        expect(json).to eq(obj_to_json_hash(user.device.sensors))
      end
    end
    
    context 'when device requests sensors' do
      before { get '/v1/sensors', headers: {'X-Device-Email' => device.email, 
        'X-Device-Token' => device.authentication_token } }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns all of the sensors requested by it\'s user' do
        expect(json).to eq(obj_to_json_hash(device.user.sensors))
      end
    end
      
    context 'when no valid token submitted' do
      before { get '/v1/sensors' }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
    
  end
end