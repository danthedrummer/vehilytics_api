FactoryBot.define do
  factory :sensor do
    sequence(:name) {|n| Faker::Pokemon.name + " (#{n})" }
    sequence(:shortname) {|n| Faker::Pokemon.location + " (#{n})" }
    unit { "%" }
  end
end