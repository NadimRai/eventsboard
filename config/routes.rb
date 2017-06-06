Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events

  resources :users, only: [:show]
  get 'seller' , to: 'events#currentuser'
  root 'events#index'
end
