Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1, format: 'json'  do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :foods
    end
  end
end
