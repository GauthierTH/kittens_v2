Rails.application.routes.draw do

  devise_for :users
  resources :items, only: [:index, :show]
  resources :carts, except: [:index, :new, :destroy]
  resources :orders

	root "items#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
