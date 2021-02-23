Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1, format: 'json' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      get 'isLike', to: 'food_likes#isLike'
      get 'allfood', to: 'foods#allfood'
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show, :destroy]
      resources :reviews, only: [:index, :create, :update, :destroy]
      resources :menus, only: [:index, :create, :update, :destroy]
      resources :winter_choises, only: [:index, :create, :destroy]
      resources :choise_foods, only: [:create, :update, :destroy]
      resource :relationships, only: [:create, :destroy]
      resource :food_likes, only: [:create, :destroy]
      resource :review_likes, only: [:create, :destroy]
    end
  end
end
