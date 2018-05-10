require 'rails_helper'

RSpec.describe 'Reports API', type: :request do
  
  describe 'POST /v1/reports' do
    let!(:user) { create(:user) }
    let!(:device) { create(:device) }
    let!(:valid_headers) { { 'device_email' => device.email, 'device_token' => device.authentication_token } }
    let!(:sensors) { create_list(:sensor, 3) }
    let!(:gathered_data) { [] }
    let!(:time) { Time.now }
    before {
      sensors.each do |s|
        d = build(:sensor_description)
        d.sensor = s
        d.save!
      end
      user.device = device
    }
    
    context 'when the request is valid' do
      before { 
        sensors.each do |sensor|
          gathered_data << {'shortname': sensor.shortname, 'value': "10" }
        end
        post '/v1/reports', params: valid_headers.merge('readings' => gathered_data, 
          'time_reported' => time, 'device_name' => device.device_name) }
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the recorded readings' do
        expect(json['readings']).to eq(obj_to_json_hash(gathered_data))
      end
    end
    
    context 'when the headers are invalid' do
      before { post '/v1/reports' }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
    
    context 'when the params are invalid' do
      before { post '/v1/reports', params: valid_headers }
      
      it 'returns a status code 400' do
        expect(response).to have_http_status(400)
      end
    end
    
  end
end