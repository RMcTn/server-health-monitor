Rails.application.routes.draw do
  get 'dashboard/show'
  get 'dashboard/index'
  devise_for :users
  resources :user, only: :show
  resources :organisations do 
    get 'problems', to: 'organisations#problems'
    resources :organisations_users, only: [:new, :create, :destroy]
    resources :servers do 
      resources :heartbeats, only: [:show, :index]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "organisations#index"
end
