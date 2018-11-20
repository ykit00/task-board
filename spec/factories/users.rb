FactoryBot.define do
  factory :user do
    name { Faker::DragonBall.character }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    after(:create) do |user|
      create_list(:task, 3, user: user)
    end
  end
end
