Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    resources :restaurants
    resources :chats do
      resources :messages
    end
  end
end

#   resources :users, only: [:index, :show] do
