Rails.application.routes.draw do
  get 'homes/index'
  get 'news/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'homes#index'
  resources :users
  resources :homes
  resources :news
  resources :articles,only: [:show]
  resources :bookmarks, only: [:create, :destroy]
end
