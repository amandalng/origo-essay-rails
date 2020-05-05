Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
    patch "essays/:id", to: "essays#mark"
    resources :essays, only: [:index, :show, :edit, :update]
  end
  resources :essays, only: [:new, :create] do
    collection do
      get 'pricing'
    end
    member do
      get 'confirmation'
    end
    resources :orders, only: [:show, :create] do
      resources :payments, only: :new
    end
  end

  # mount StripeEvent::Engine, at: '/stripe-webhooks'
end
