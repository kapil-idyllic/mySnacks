Rails.application.routes.draw do
  get '/snacks/total_orders' => 'snacks#total_orders'
  get '/snacks/whos_order_what' => 'snacks#whos_order_what'
  get '/snacks/todays_order' => 'snacks#todays_order'
  resources :snacks
  root to: 'snacks#show'
  post '/snacks/place_order' => 'snacks#place_order'

    get '/user/show' => 'user#index'
    match '/user/add', to: 'user#create', via: [:get, :post]
    match '/user/authenticate', to: 'user#authenticate_mobile_user', via: [:get, :post]


  # should put put ideally. just being irresponsible here
  get '/snacks/:id/destroy_order' => 'snacks#destroy_order'

  #mobile routes

end
