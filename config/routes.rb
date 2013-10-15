SilentAuction::Application.routes.draw do
  
  devise_for :users

  root 'auction#index'

  # Auction screen
  get 'auction', to: 'auction#index'
  get 'amount_raised', to: 'auction#amount_raised'
  get 'time_left', to: 'auction#time_left'

  resources :preferences, only: [:index, :show, :update]

  # iPad bidding
  resources :user_groups, only: [:index] do
    resources :users, only: [:index]
  end

  resources :users, only: [:index] do
    resources :items, only: [:index, :show] do
      post '', on: :member, to: 'items#place_bid'
    end
  end

  # Users interface
  get 'authenticate', to: 'authenticate_user#tables', as: 'select_table'
  get 'authenticate/:id', to: 'authenticate_user#users', as: 'select_user'
  post 'authenticate/:id', to: 'authenticate_user#authenticate', as: 'authenticate'

end
