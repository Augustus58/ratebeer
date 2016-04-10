Rails.application.routes.draw do
  resources :styles

  resources :memberships

  resources :beer_clubs

  resources :users do
    post 'toggle_froze', on: :member
  end

  resources :beers
  get 'beerlist', to:'beers#list'
  get 'ngbeerlist', to:'beers#nglist'
  
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  get 'brewerieslist', to:'breweries#list'
  
  root 'breweries#index'
  
  resources :ratings, only: [:index, :new, :create, :destroy]
  
  resource :session, only: [:new, :create, :delete]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create_oauth'

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'

end
