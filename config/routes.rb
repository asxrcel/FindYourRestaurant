Rails.application.routes.draw do
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard"

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:show, :new, :create, :delete] do
    resources :restaurants, only: [:index, :show, :delete]
    resources :chats do
      resources :messages
    end
  end
end

#   resources :users, only: [:index, :show] do
