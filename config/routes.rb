Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get 'main' => "homes#main"
  get 'error' => "homes#error"

  # userがログインしている時のrootページ
  authenticated :user do
    root "homes#main", as: :authenticated_root  # Pathは一意でなければならないため被らないように名前をつける
  end

  # 未ログイン時のrootページ
  devise_scope :user do
    root 'homes#top'
  end

  post 'onesignal/:user_id/add', to: 'users#onesignal_add', as: 'onesignal_add'
  post 'onesignal/:user_id/remove', to: 'users#onesignal_remove', as: 'onesignal_remove'

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

  namespace :admin do
    root to: 'homes#top'

    resources :rooms, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :introduces, only: [:index, :show, :destroy]
    get "search" => "searches#search"
  end
end
