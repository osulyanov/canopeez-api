Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'users'
    end
  end
end
