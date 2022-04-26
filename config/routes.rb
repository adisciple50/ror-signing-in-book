Rails.application.routes.draw do
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
  get '/login',to: 'authentication#login'
  post '/authenticate',to: 'authentication#authenticate'
  get '/logout',to: 'authentication#logout'
end
