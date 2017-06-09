Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    resources :users, only: [:index]
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:index]
    resources :attendances, only: [:index]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    resources :comments, only: [:create]
    resources :attendances, only: [:create]
  end

  resources :categories, only: [:show]

  resources :users, only: [:show]
  get 'seller' , to: 'events#currentuser'
  root 'events#index'
end
