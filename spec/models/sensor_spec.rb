require 'rails_helper'

RSpec.describe Sensor, type: :model do
  it { should have_many(:readings) }
  it { should have_and_belong_to_many(:devices) }
  it { should have_and_belong_to_many(:users) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:shortname) }
  it { should validate_presence_of(:unit) }
  
  # it { should validate_uniqueness_of(:name) }
  # it { should validate_uniqueness_of(:shortname) }
end
