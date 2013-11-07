SilentAuction::Application.routes.draw do

  root 'application#index'

  # Auction screen
  get 'auction', to: 'auction#index'
  get 'amount_raised', to: 'auction#amount_raised'
  get 'time_left', to: 'auction#time_left'

  # Administration
  resources :preferences, only: [:index, :show, :update]
  resources :users

  # Authentication
  get 'authenticate', to: 'authentication#tables', as: 'authenticate_select_table'
  get 'authenticate/:id', to: 'authentication#users', as: 'authenticate_select_user'
  get 'authenticate/:id/pin', to: 'authentication#user_pin', as: 'user_pin'
  post 'authenticate/:id/pin', to: 'authentication#user_pin'

  # iPad bidding
  get 'select_table', to: 'host_bid#select_table', as: 'select_table'
  get 'select_user/:table_id', to: 'host_bid#select_user', as: 'select_user'
  get 'select_item/:user_id', to: 'host_bid#select_item', as: 'select_item'
  get 'select_amount/:user_id/:item_id', to: 'host_bid#select_amount', as: 'select_amount'
  post 'place_bid/:user_id/:item_id', to: 'host_bid#place_bid', as: 'place_host_bid'

  # Users interface
  get 'list_items', to: 'user_bid#list_items', as: 'list_items'
  post 'place_bid', to: 'user_bid#place_bid', as: 'place_user_bid'

  devise_for :user, :path => '', :path_names => { :sign_in => "authenticate" }

end
