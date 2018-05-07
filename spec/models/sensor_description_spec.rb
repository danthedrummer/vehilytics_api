require 'rails_helper'

RSpec.describe SensorDescription, type: :model do
  it { should belong_to(:sensor) }
  
  it { should validate_presence_of(:info) }
end
