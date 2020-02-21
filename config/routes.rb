Rails.application.routes.draw do
  resources :tasks
  root to: 'home#index'

  get '*path', to: 'home#index'
end
