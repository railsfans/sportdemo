Sportdemo::Application.routes.draw do

  match "student/historydata"=>"student#historydata"
  match "student/personinfo"=>"student#personinfo"
  match "student/datagraph"=>"student#datagraph"
  match "student/rank"=>"student#rank"
  match "student/feedback"=>"student#feedback"

  match "teacher/classgrid"=>"teacher#classgrid"
  match "teacher/semestergrid"=>"teacher#semestergrid"
  match "teacher/personinfo"=>"teacher#personinfo"
  match "teacher/classcal"=>"teacher#classcal"

  match "manager/phonegrid"=>"manager#phonegrid"
  match "manager/basestationgrid"=>"manager#basestationgrid"
  match "manager/baidumap"=>"manager#baidumap"
  match "manager/googlemap"=>"manager#googlemap"
  match "manager/teachermanager"=>"manager#teachermanager"
  match "manager/studentmanager"=>"manager#studentmanager"
  match "manager/personinfo"=>"manager#personinfo"
  match "sessions/editpassword"=>"sessions#editpassword"

  match "application/setlanguage"=>"application#setlanguage"
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
   root :to => 'student#historydata'
    resource :session
    match '/login' => "sessions#new", :as => "login" 
    match '/logout' => "sessions#destroy", :as => "logout"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'
   match '*a', :to => 'sessions#routeerror'
end
