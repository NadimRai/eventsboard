Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events

  get 'seller' , to: 'events#currentuser'
  root 'events#index'
end
