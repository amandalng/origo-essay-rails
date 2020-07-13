Rails.application.routes.draw do
  devise_for :users do
    get ':user/edit-profile' => 'devise/registration#edit', :as => :edit_user_profile
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
    resources :essays, only: [:index, :show]
    # patch "essays/:id", to: "essays#mark"
    resources :leads, only: [:index, :show]
  end
  resources :essays, only: [:new, :create, :edit, :update] do
    collection do
      get 'pricing'
    end
    member do
      get 'confirmation'
      get 'download', format: 'docx'
    end
    resources :orders, only: [:show, :create] do
      resources :payments, only: :new
    end
  end
  resources :leads, only: [:new, :create, :edit, :update]

  # mount StripeEvent::Engine, at: '/stripe-webhooks'
end
