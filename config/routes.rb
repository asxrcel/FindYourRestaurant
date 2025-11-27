Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :restaurants, only: [:index, :show, :destroy]

  resources :users, only: [:show]

  resources :chats, only: [:create]
  resources :chats, only: [:show] do
    resources :messages, only: [:create]
    patch "restaurants", to: "restaurants#update"
  end

  resources :profils, only: [:create]
end
