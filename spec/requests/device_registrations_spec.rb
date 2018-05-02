require 'rails_helper'

RSpec.describe 'Device Registrations API', type: :request do
  
  describe 'POST /devices' do
    let(:valid_attributes) { { device: { email: Faker::Internet.unique.email, 
      device_name: Faker::StarWars.unique.droid, password: "password", password_confirmation: "password" } } }
    
    context 'when the request is valid' do
      before { post '/devices', params: valid_attributes }
      
      it 'returns authentication token for the new device' do
        expect(json).to have_key('token')
      end
      
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
    let(:device) { Device.create(email: "duplicate@example.com", device_name: "duplicate_name", password: "password", password_confirmation: "password") }
    
    let(:duplicate_email) { { device: { email: device.email, 
      device_name: Faker::StarWars.unique.droid, password: "password", password_confirmation: "password" } } }
    
    context 'when the email is already registered' do
      before { post '/devices', params: duplicate_email }
      
      it 'returns a validation failure message' do
        expect(response.body).to match(/Email address already registered./)
      end
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
    
    let(:duplicate_device_name) { { device: { email: Faker::Internet.unique.email, 
      device_name: device.device_name, password: "password", password_confirmation: "password" } } }
    
    context 'when the device name is already registered' do
      before { post '/devices', params: duplicate_device_name }
      
      it 'returns a validation failure message' do
        expect(response.body).to match(/Device name already registered./)
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