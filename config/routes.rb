Rails.application.routes.draw do
  get 'authentication/login'
  get 'authentication/logout'
  get 'search/search'
  get 'search/view'
  resources :admins
  resources :entries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "entries#new"
  get '/search',to: "search#search"
  get '/retrieve',to: "search#view"
  # get '/login', to: redirect('/admins')
  # get '/logout', to: redirect('/admins')
  post '/login',to: 'admins#login'
  get '/logout',to: 'admins#logout'
end
