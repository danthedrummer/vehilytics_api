FactoryBot.define do
  factory :reading do
    value { "#{rand(100)}" }
  end
end