# Tasks
20.times do |n|
  title = "Task#{n+1}"
  status = [Task.statuses.to_a.sample].to_h.first[1]

  Task.create!(title: title, status: status)
end