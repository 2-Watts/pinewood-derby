PinewoodDerby::Application.routes.draw do
  root to: 'board#welcome'
  get 'board' => 'board#status_board'
  get 'board/welcome' => 'board#welcome'
  get 'runs/:id/postpone' => 'runs#postpone'
  post 'reset_derby' => 'derby#reset'
  resources :login, only: [:new, :create]
  resources(:contestants) { member { post 'reactivate' } }
  resources :races, only: [:new, :index]

  faye_server '/faye', timeout: 1, engine: {type: Faye::Redis, host: 'localhost'} do
    map '/announce/**' => AnnounceController
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
