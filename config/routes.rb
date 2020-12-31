Rails.application.routes.draw do
  devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "users#index"
  devise_for :users
  resources :users, only: [:show,:edit,:update,:index, :destroy]
end
