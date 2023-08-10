Rails.application.routes.draw do
  get 'articles/show'
  get 'homes/index'
  get 'news/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'homes#index'
  resources :homes
  resources :news, only: [:index, :show]
  resource :article
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
