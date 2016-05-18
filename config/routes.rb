Rails.application.routes.draw do
  use_doorkeeper
  ActiveAdmin.routes(self)
  root to: 'home#index'
  devise_for :user, controllers: {
      sessions: 'user/sessions',
      passwords: 'user/password',
      registrations: 'user/registrations'
  }
end
