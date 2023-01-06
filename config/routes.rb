Rails.application.routes.draw do
  get 'rooms/show'
  get 'matches/index'
  devise_for :users

  root to: "homes#top"
  get 'homes/about' => "homes#about"

  resource :users, only: [] do
    get 'my_page' => "users#my_page"
    get 'information/edit' => "users#edit"
    patch 'information' => "users#update"
    get 'unsubscribe' => "users#unsubscribe"
    patch 'withdrawal' => "users#withdrawal"
  end

  resources :users, only: [:show] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :introduces, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :posts, only: [:index, :create, :edit, :update, :destroy, :show] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

end
