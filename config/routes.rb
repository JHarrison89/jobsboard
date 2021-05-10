Rails.application.routes.draw do
  get 'jobs/saved'
  get 'jobs/save/:id', to: "jobs#save", as: :save
  patch 'jobs/save/:id', to: "jobs#remove", as: :remove
  get 'jobs/create'
  devise_for :users
  root to: 'pages#home'
  resources :jobs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
