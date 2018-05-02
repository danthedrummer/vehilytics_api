FactoryBot.define do
  factory :report do
    time_reported { Time.now }
    device
  end
end