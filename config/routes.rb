Rails.application.routes.draw do
  use_doorkeeper
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
      sessions: 'user/sessions',
      passwords: 'user/password',
      registrations: 'user/registrations'
  }
  root to: 'home#index'
end
