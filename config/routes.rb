Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :projects do
      resources :screens, shallow: true do
        resources :screen_links, only: [:index, :create, :destroy]
      end

      post :duplicate, on: :member
    end
  end

  resources :projects, only: [:index, :show]
  resources :screens, only: [:show] do
    post :notes, on: :member
  end

  resources :demo_sessions, path: 'session', only: [:show] do
    post :email, on: :member
  end
  get 'sessions/:id/complete', to: 'demo_sessions#complete', as: 'complete_session'

  require "sidekiq/web"
  authenticated :user, ->(user) { user.superuser? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root to: 'projects#index'
end
