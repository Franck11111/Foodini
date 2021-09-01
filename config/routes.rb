Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'components', to: 'pages#components', as: :components
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :orders, only: [:show, :new, :create] do
    resources :payments, only: [ :new, :create ]
  end
end
