SilentAuction::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.

  root 'auction#index'
  get 'auction', to: 'auction#index'

  resources :user_groups, only: [:index] do
    resources :users, only: [:index]
  end

  resources :users, only: [:index] do
    resources :items, only: [:index, :show] do
      post '', on: :member, to: 'items#place_bid'
    end
  end

end
