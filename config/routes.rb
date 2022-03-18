Rails.application.routes.draw do
  resources :admins
  resources :entries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "entries#new"
  get '/retrieve',to: "entries#search"
  post '/login',to: 'admins#login'
  post '/login',to: 'admins#logout'
end
