# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"
  # Login or Register new user
  post "/authenticate", to: "users#authenticate", as: :authenticate
  get "/logout", to: "users#logout", as: :logout
  resources :movies, only: [:index, :new, :create]
end
