FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Test Task ##{n}" }
    description { "Description" }
  end
end
