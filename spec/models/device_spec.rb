require 'rails_helper'

RSpec.describe Device, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:reports) }
  it { should have_and_belong_to_many(:sensors) }
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:device_name) }
end
