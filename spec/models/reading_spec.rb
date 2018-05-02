require 'rails_helper'

RSpec.describe Reading, type: :model do
  it { should belong_to(:sensor) }
  it { should belong_to(:report) }
  
  it { should validate_presence_of(:value) }
end
