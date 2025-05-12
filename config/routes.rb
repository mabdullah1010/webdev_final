Rails.application.routes.draw do

    root 'static_pages#home'
    get '/home',    to: 'static_pages#home'
    get '/about',   to: 'static_pages#about'
    get '/help',    to: 'static_pages#help'
  
    # User management
    resources :users 
      # User management
    get '/signup',  to: 'users#new'  # More intuitive than /users/new
  
    resources :session_controllers
    # Sessions (login/logout)
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

    resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
    resources :documents

    resources :documents do
      resources :comments, only: [:create, :new]
    end

  
    # Health check
    get "up" => "rails/health#show", as: :rails_health_check

end
