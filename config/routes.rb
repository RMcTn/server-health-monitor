Rails.application.routes.draw do
  resources :servers do 
    resources :heartbeats
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "servers#index"
end
