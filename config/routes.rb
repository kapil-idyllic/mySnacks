Rails.application.routes.draw do
  match '/snacks/total_orders', to: 'snacks#total_orders', via: [:get, :post]
  match '/snacks/whos_order_what', to: 'snacks#whos_order_what', via: [:get, :post]
  match '/snacks/todays_order', to: 'snacks#todays_order', via: [:get, :post]
  resources :snacks
  root to: 'snacks#show'
  post '/snacks/place_order' => 'snacks#place_order'

    get '/user/show' => 'user#index'
    match '/user/add', to: 'user#create_user', via: [:get, :post]
    match '/user/authenticate', to: 'user#authenticate_mobile_user', via: [:get, :post]


  # should put put ideally. just being irresponsible here
  get '/snacks/:id/destroy_order' => 'snacks#destroy_order'

  #mobile routes

end
