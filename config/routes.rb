Rails.application.routes.draw do
  use_doorkeeper
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/password',
      registrations: 'users/registrations'
  }
  root to: 'home#index'
end
