Rails.application.routes.draw do
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  post 'users' => 'users#create'
  resources :users, only: :create do
    collection do
      get 'edit' => 'users#edit'
      put 'save' => 'users#update'
      patch 'save' => 'users#update'
    end
  end
end
