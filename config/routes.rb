Rails.application.routes.draw do
  get 'skill_tags/show'
  get 'skill/show'
  get 'skill/show'
  get 'sessions/new'
  root "static_pages#home"
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :user_skills, only: [:index, :create, :destroy]
  resources :endorsements, only: :create
  resources :skill_tags, only: [:show]
end
