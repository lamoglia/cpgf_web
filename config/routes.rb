Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'site#index'

  get 'sobre' => 'application#about'

  match 'portadores/:page', :to => 'people#index', :via => :get, defaults: {page: 1}
  get 'portadores' => 'people#index'
  match 'portador/:id/:page', :to => 'people#view', :via => :get
  get 'portador/:id' => 'people#view', as: :person_path

  match 'favorecidos/:page', :to => 'favored#index', :via => :get
  get 'favorecidos' => 'favored#index'
  match 'favorecido/:id/:page', :to => 'favored#view', :via => :get
  get 'favorecido/:id' => 'favored#view', as: :favored_path

  match 'transacoes/:page', :to => 'transactions#index', :via => :get
  get 'transacoes' => 'transactions#index'

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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
