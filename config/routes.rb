Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    resources :tasks
    resources :sessions
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :profile
  end

  # TODO: Active Storageでアップロードしたファイルをフロントで表示させるときに使用している
  # ただ、よりよい書き方があるはずなので要検討である
  get '/rails/active_storage/blobs/:signed_id/:filename', to: 'active_storage/blobs#show'
  get '/rails/active_storage/disk/:encoded_key/:filename', to: 'active_storage/disk#show'

  get '*path', to: 'home#index'
end
