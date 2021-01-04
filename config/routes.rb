Rails.application.routes.draw do
  devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show,:edit,:update,:index, :destroy]
  resources :users do
    member do
      post 'follow' => 'users#follow'
      post 'unfollow' => 'users#unfollow'
    end
  end
  resources :recipes do
    member do
        put 'like' => 'recipes#like'
        get 'board' => 'recipes#board'
    end
  end
  root to: "recipes#index"
  resources :categories, only: [:show,:index]

end
