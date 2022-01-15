Rails.application.routes.draw do
  resources :organisations do 
    resources :servers do 
      resources :heartbeats, only: [:show, :index]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "organisations#index"
end
