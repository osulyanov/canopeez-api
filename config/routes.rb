Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  use_doorkeeper
  ActiveAdmin.routes(self)
  root to: 'home#index'
end
