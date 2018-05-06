FactoryBot.define do
  factory :reminder do
    sequence(:title) {|n| Faker::HarryPotter.character + " (#{n})" }
    sequence(:weekly_frequency) { rand(10..50) }
    sequence(:description) {|n| Faker::HarryPotter.quote + " (#{n})"}
  end
end