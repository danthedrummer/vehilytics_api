FactoryBot.define do
  factory :readings do
    value { "#{rand(100)}" }
    report
    sensor
  end
end