FactoryBot.define do
  pass = Faker::Internet.password(8)
  factory :device do
    sequence(:email) {|n| "#{n}" + Faker::Internet.email }
    sequence(:device_name) {|n| Faker::StarWars.droid + " (#{n})" }
    password { pass }
    password_confirmation { pass }
    # authentication_token { "devicetoken789" }
  end
end