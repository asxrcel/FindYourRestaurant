Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :restaurants, only: [:index, :show]
  resources :chats, only: [:create]
  resources :users, only: [:show]
  resources :chats, only: [:show] do
    resources :messages, only: [:create]
  end
end
