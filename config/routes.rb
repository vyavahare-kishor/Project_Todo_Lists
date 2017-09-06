Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users, :controllers => {:registrations => "registrations"}

  get '/projects/assign', to: "projects#assign"
  resources :projects
  resources :todo_lists

end
