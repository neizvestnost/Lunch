# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    root to: 'users/sessions#new'
  end
  resources :menus,  only: %i[index new create]
  resources :orders, only: %i[index create]
  resources :users,  only: %i[index]

  namespace :api do
    namespace :v1 do
      resources :orders, only: %i[index]
    end
  end
end
