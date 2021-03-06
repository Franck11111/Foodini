Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'components', to: 'pages#components', as: :components
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'payment_made/:id', to:'orders#payment_made', as: :payment_made

  resources :orders, only: [:index, :show, :new, :create, :update] do
    resources :payments, only: [ :new, :create ]
  end
end
