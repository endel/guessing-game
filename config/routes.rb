Guessingame::Application.routes.draw do

  # Game routes
  get "game" => "game#index"
  get "game/index", :as => :game
  get "game/ranking", :as => :game_ranking
  get "game/ask", :as => :game_ask
  get "game/play", :as => :game_play
  post "game/answer", :as => :game_answer

  # Rankings routes
  get "rankings" => "rankings#index", :as => :ranking
  get "rankings/weekly", :as => :ranking_weekly
  get "rankings/summary", :as => :ranking_summary

  # User routes
  get "user/index"
  get "user/profile/:id" => "user#profile"
  get "user/search", :as => :search_user
  get "user/(:id)" => "user#show", :as => :user

  # Shop routes
  get "shop/index", :as => :shop
  post "shop/buy", :as => :shop_buy

  root :to => 'user#login'

  # The priority is based upon order of creation:
  # first created -> highest priority.
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  #
  # Omniauth
  #
  get   '/login', :to => 'sessions#new', :as => :login
  match '/logout', :to => 'sessions#destroy', :as => :logout
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
