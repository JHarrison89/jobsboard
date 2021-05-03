Rails.application.routes.draw do
  # get 'jobs/index'
  # get 'jobs/show'
  # get 'jobs/new'
  get 'jobs/create'
  devise_for :users
  root to: 'pages#home'
  resources :jobs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
