FactoryBot.define do
  factory :user do
    name { Faker::DragonBall.character }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
