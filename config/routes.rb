Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :movies

      root to: "users#index"
    end
  resources :subscribers
  put 'subscriber_update' => 'subscribers#update'
  devise_for :users, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:  'movies#index'
end
