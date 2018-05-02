FactoryBot.define do
  pass = Faker::Internet.password(8)
  factory :user do
    sequence(:email) {|n| "#{n}" + Faker::Internet.unique.email }
    password { pass }
    password_confirmation { pass }
    # authentication_token { "usertoken123" }
  end
end