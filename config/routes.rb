# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Dashboard como root
  root "dashboard#index"
  get "dashboard", to: "dashboard#index", as: :dashboard

  # Clientes
  resources :clients

  # Expedientes con recursos anidados
  resources :expedientes do
    resources :deadlines, only: [:new, :create]
    resources :movements, only: [:create, :edit, :update, :destroy]
  end

  # Plazos (vista global + acciones especiales)
  resources :deadlines, only: [:index, :edit, :update, :destroy] do
    collection do
      get :calendar
    end
    member do
      patch :mark_completed
      patch :mark_expired
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
