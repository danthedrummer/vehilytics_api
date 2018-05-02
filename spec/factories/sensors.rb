FactoryBot.define do
  factory :sensor do
    name { Faker::Space.unique.galaxy }
    shortname { Faker::Space.unique.planet }
    unit { "%" }
  end
end