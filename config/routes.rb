SilentAuction::Application.routes.draw do

  root 'application#index'

  # Auction screen
  get 'auction', to: 'auction#index'
  get 'amount_raised', to: 'auction#amount_raised'
  get 'time_left', to: 'auction#time_left'

  # Administration
  get 'admin', to: 'admin#index'
  get 'import_items', to: 'admin#import_items'
  get 'import_users', to: 'admin#import_users'
  get 'user_cards', to: 'admin#user_cards'
  post 'import_items_google_drive', to: 'admin#import_items_google_drive'
  post 'import_tables_google_drive', to: 'admin#import_tables_google_drive'

  resources :preferences
  resources :user_groups
  resources :users
  resources :items
  resources :bids

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
  get 'all_items', to: 'user_bid#all_items', as: 'all_items'
  get 'current_bids', to: 'user_bid#current_bids', as: 'current_bids'
  post 'place_bid', to: 'user_bid#place_bid', as: 'place_user_bid'
  get 'legend', to: 'user_bid#legend', as: 'legend'

  devise_for :user, :path => '', :path_names => { :sign_in => "authenticate" }

end
