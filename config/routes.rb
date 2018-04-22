Promobug::Application.routes.draw do
  resources :schedules

  resources :offers

  resources :agendas

  resources :interests

  devise_for :users

  root :to => "home#index"

  # home
  get 'google_login' =>             'home#google_login'
  get 'google_login_response' =>    'home#google_login_response'
  get 'list_google_agendas' =>      'home#list_google_agendas'
  get 'check_new_offers' =>         'home#check_new_offers'

  #agendas
  post 'agendas/inactivate/:id' =>   'agendas#inactivate'
  post 'google_agenda/create_google_agenda' => 'agendas#create_google_agenda'

  namespace :api do
    post "user/login" =>              "users#login"
    post "user/sign_up" =>            "users#sign_up"
    post "interests/new" =>           "interests#new"
    get  "interests/get/:id" =>       "interests#get"
    get "interests/list" =>          "interests#list"
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
