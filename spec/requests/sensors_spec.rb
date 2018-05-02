require 'rails_helper'

RSpec.describe 'Sensors API', type: :request do
  let!(:sensors) { create_list(:sensor, 10) }
  let!(:user) { create(:user) }
  
end