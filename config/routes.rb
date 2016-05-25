Rails.application.routes.draw do
  apipie
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  namespace :admin do
    resources :categories do
      resources :startups
    end
    resources :users do
      resources :startups
    end
    resources :startups do
      resources :founders
      resources :references
    end
  end

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'users'
    end
  end
end
