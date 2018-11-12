FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Test Task ##{n}" }
    description { "Description" }
    sequence(:deadline) { |n| Date.today + 14 + n }
  end
end
