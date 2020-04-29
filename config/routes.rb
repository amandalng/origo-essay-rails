Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
    resources :essays, only: [:index, :show]
    patch "essays/:id", to: "essays#mark"
  end
  resources :essays, only: [:new, :create] do
    collection do
      get 'pricing'
    end
    member do
      get 'confirmation'
    end
  end

end
