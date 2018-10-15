FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Test Task ##{n}" }
    description { "Description" }
    deadline { "2050/01/01" }
  end
end
