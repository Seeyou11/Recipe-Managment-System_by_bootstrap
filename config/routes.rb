Rails.application.routes.draw do
  resources :comments
  resources :ratings
  resources :controllers
  resources :recipes
  root 'pages#home'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  resources :categories, except: [ :destroy ]
end
