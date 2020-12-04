Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  namespace :admin do
    resources :projects, only: [:index, :show] do
      resources :screens, shallow: true do
        resources :screen_links, only: [:index, :create, :destroy]
      end
    end
  end

  resources :projects, only: [:index, :show]
  resources :screens, only: [:show]

  root to: 'projects#index'
end
