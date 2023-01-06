Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get 'introduces/index'
  get 'introduces/new'
  get 'introduces/edit'
  get 'rooms/show'
  get 'matches/index'
  get 'users/my_page'
  get 'users/edit'
  get 'users/show'
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
