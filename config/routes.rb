SilentAuction::Application.routes.draw do
  
  root 'auction#index'

  get 'auction', to: 'auction#index'
  get 'amount_raised', to: 'auction#amount_raised'
  get 'time_left', to: 'auction#time_left'

  resources :preferences, only: [:index, :show, :update]

  resources :user_groups, only: [:index] do
    resources :users, only: [:index]
  end

  resources :users, only: [:index] do
    resources :items, only: [:index, :show] do
      post '', on: :member, to: 'items#place_bid'
    end
  end

end
