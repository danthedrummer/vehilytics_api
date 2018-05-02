require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:device) }
  it { should have_and_belong_to_many(:sensors) }
  
  it { should validate_presence_of(:email) }
end
