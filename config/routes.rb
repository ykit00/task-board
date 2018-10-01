Rails.application.routes.draw do
  get '/tasks/new', to: 'tasks#new'
  post '/tasks', to: 'tasks#create'
  get '/tasks/index', to: 'tasks#index'
end
