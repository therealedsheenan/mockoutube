Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: %i[show new edit create update]
  resources :sessions, only: %i[new create destroy]

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  get 'password/reset', to: 'passwords#new_password', as: :password_reset
  get 'password/forgot', to: 'passwords#index', as: :password_forget
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
end
