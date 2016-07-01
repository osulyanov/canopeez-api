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

  namespace :api, defaults: { format: 'json' } do
    match '*any' => 'api#options', via: [:options]
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users'
      resource :credentials, only: [:show], path: :me, me: true do
        resources :favorites, only: [:index]
        resources :ratings, only: [:index]
        resources :comments, only: [:index]
      end
      resources :startups do
        member do
          resources :founders, only: [:create]
          resources :references, only: [:create]
        end
      end
      resources :founders, except: [:create]
      resources :references, except: [:create]
      resources :categories, only: [:index]
      resources :partners, only: [:index]
      resources :contact_messages, only: [:create]
    end
  end
end
