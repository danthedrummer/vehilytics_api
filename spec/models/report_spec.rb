require 'rails_helper'

RSpec.describe Report, type: :model do
  it { should belong_to(:device) }
  it { should have_many(:readings) }
  
  it { should validate_presence_of(:time_reported) }
end
