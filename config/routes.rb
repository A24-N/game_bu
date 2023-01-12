Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"
  get 'about' => "homes#about"

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'unsubscribe' => "users#unsubscribe"
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :introduces, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end


  resources :rooms, only: [:create, :show, :destroy]
    resources :messages, only: [:create, :destroy]
  resources :matches, only: [:index, :destroy, :create]
  patch 'matches/matching' => "matches#matching"

end
