Rails.application.routes.draw do
  get 'dashboard/show'
  get 'dashboard/index'

  get 'failingserver', to: "demo#failing"
  devise_for :users
  resources :user, only: :show
  resources :organisations do 
    get 'problems', to: 'organisations#problems'
    get 'warnings', to: 'organisations#warnings'
    get 'healthy', to: 'organisations#healthy'
    resources :organisations_users, only: [:index, :new, :create, :destroy]
    resources :servers do 
      resources :heartbeats, only: [:show]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "organisations#index"
end
