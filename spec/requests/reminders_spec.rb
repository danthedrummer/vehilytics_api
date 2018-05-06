require 'rails_helper'

RSpec.describe 'Reminders API', type: :request do
  
  describe 'GET /v1/reminders' do
    let!(:reminders) { create_list(:reminder, 4) }
    
    context 'when a user requests the list of reminders' do
      before { get '/v1/reminders' }
      
      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns a list of all reminders' do
        expect(json).to eq(obj_to_json_hash(reminders))
      end
    end
  end
  
end