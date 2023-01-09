Rails.application.routes.draw do
  get 'rooms/show'
  get 'matches/index'
  devise_for :users

  root to: "homes#top"
  get 'about' => "homes#about"

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'unsubscribe' => "users#unsubscribe"
    patch 'status_change' => "users#status_change"
    patch 'matching' => "users#matching"
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :introduces, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :matches, only: [:index, :destroy]

end
