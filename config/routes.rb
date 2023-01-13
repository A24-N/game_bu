Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: "homes#top"
  get 'about' => "homes#about"

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'unsubscribe' => "users#unsubscribe"
    get 'favorites' => 'favorites#favorite'
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :introduces, only: [:index, :create, :new, :edit, :update, :destroy]
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :rooms, only: [:create, :show, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :matches, only: [:index, :destroy, :create]

  patch 'matches/matching' => "matches#matching"
  get "search" => "searches#search"
end
