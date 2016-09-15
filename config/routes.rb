Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  post 'users' => 'users#create'
  get 'pages/:name' => 'pages#show', as: :page
  resources :users, only: :create do
    collection do
      get 'edit' => 'users#edit'
      put 'save' => 'users#update'
      patch 'save' => 'users#update'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index] do
        get ':email' => 'users#show', on: :collection
      end
    end
  end
end
