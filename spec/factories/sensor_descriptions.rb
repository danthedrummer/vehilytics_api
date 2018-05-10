FactoryBot.define do
  factory :sensor_description do
    sequence(:info) {|n| Faker::Dune.quote + " (#{n})" }
    sequence(:upper_range) { 10000000000.0}
    sequence(:lower_range) { -10000000000.0}
  end
end