# config/routes.rb

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: redirect('/products')

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show] do
    resources :products, only: [:index]  # Nested route for products by category
  end

  resource :cart, only: [:show, :destroy]  # Singular resource for cart
  resources :line_items, only: [:create, :update, :destroy] do
    member do
      patch 'decrement'
    end
  end

  get '/admin', to: 'admin_dashboard#index'
  get 'up', to: 'rails/health#show', as: :rails_health_check

  resources :customers
  resources :orders, only: [:new, :create, :index] do
    member do
      get 'success'
      get 'show_invoice'
    end
  end

  get '/contact', to: 'static_pages#show', defaults: { title: 'Contact' }
  get '/about', to: 'static_pages#show', defaults: { title: 'About' }
end
