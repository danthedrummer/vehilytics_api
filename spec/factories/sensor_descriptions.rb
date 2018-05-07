FactoryBot.define do
  factory :sensor_description do
    sequence(:info) {|n| Faker::Dune.quote + " (#{n})" }
    sequence(:upper_range) { (rand()*10).to_d}
    sequence(:lower_range) { (rand()*10).to_d}
  end
end