Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1, format: 'json' do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      get 'isLike', to: 'food_likes#isLike'
      get 'allfood', to: 'foods#allfood'
      get 'new_food', to: 'foods#new_food'
      get 'new_plan_food', to: 'foods#new_plan_food'
      resources :foods, only: %i[index show create update destroy]
      resources :users, only: %i[index show destroy]
      resources :reviews, only: %i[index create update destroy]
      resources :menus, only: %i[index create update destroy]
      resources :winter_choises, only: %i[index create destroy]
      resources :recommends, only: %i[index create destroy]
      resources :choise_foods, only: %i[create update destroy]
      resource :relationships, only: %i[create destroy]
      resource :food_likes, only: %i[create destroy]
      resource :review_likes, only: %i[create destroy]
      get 'health_check', to: 'health_check#index'
    end
  end
end
