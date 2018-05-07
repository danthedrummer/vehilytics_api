require 'rails_helper'

RSpec.describe 'Readings API', type: :request do
  
  describe 'GET /v1/readings' do
    let!(:user) { create(:user) }
    let!(:valid_headers) { { 'user_email' => user.email, 'user_token' => user.authentication_token } }
    let!(:device) { create(:device) }
    let!(:report) { build(:report) }
    let!(:readings) { build_list(:reading, 4) }
    before {
      user.device = device
      device.reports << report
      report.device = device
      report.save
      readings.each do |reading|
        reading.report = report
        s = create(:sensor)
        d = build(:sensor_description)
        d.sensor = s
        d.save
        reading.sensor = s
        reading.save
      end
    }
    
    context 'when the request is valid' do
      before { get '/v1/readings', params: valid_headers }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all readings belonging to that user' do
        expected = []
        readings.each do |r|
          expected << {'sensor' => r.sensor.shortname, 'value' => r.value, 'time_reported' => r.report.time_reported}
        end
        expect(json['readings']).to eq(obj_to_json_hash(expected))
      end
    end
    
    context 'when a filtered request is valid' do
      before { get '/v1/readings', params: valid_headers.merge({ 'sensor' => readings[2].sensor.shortname }) }
      
      it 'returns all readings for that sensor belonging to that user' do
        expected = {'sensor' => readings[2].sensor.shortname, 'value' => readings[2].value, 'time_reported' => readings[2].report.time_reported}
        expect(json['readings'][0]).to eq(obj_to_json_hash(expected))
      end
    end
    
    context 'when the request headers are invalid' do
      before { get '/v1/readings' }
      
      it 'returns a status code 401' do
        expect(response).to have_http_status(401)
      end
    end
    
  end
end