FactoryBot.define do
  pass = Faker::Internet.password(8)
  factory :device do
    email { Faker::Internet.unique.email }
    device_name { Faker::StarWars.unique.droid }
    password { pass }
    password_confirmation { pass }
    # authentication_token { "devicetoken789" }
  end
end