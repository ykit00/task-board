# Tasks
100.times do |n|
  title = "Task#{n+1}"
  status = [Task.statuses.to_a.sample].to_h.first[1]

  Task.create!(title: title, status: status)
end

# Users
User.create!(name: "John Doe",
             email: "johndoe@example.com",
             password: "nicesense",
             password_confirmation: "nicesense") if Rails.env.development?

User.create!(name: "test user",
             email: "testuser@example.com",
             password: "password",
             password_confirmation: "password") if Rails.env.development?