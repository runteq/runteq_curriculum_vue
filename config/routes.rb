Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    resources :tasks
    resources :sessions
  end

  get '*path', to: 'home#index'
end
