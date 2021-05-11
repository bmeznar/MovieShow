Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :movies

      root to: "users#index"
    end
  get 'watchlists/update'
  get 'subscribers#update', as: 'subscribers_update'
  resources :trailers
  resources :create_trailers
  resources :movies
  resources :subscribers
  devise_for :users, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:  'movies#index'
end
