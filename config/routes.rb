Pomtv::Application.routes.draw do

  match 'user_sessions/new' => 'user_sessions#new', :as => :login
  match 'user_sessions/logout/:id' => 'user_sessions#logout', :as => :logout

  resources :users
  resources :user_sessions

  match 'install_books/show_sorted_install' => 'install_books#show_sorted_install', :as => :show_sorted_install
  match 'cust_infs/show_sorted' => 'cust_infs#show_sorted', :as => :show_sorted
  
  match 'install_books/edit_booking_fields' => 'install_books#edit_booking_fields', :as => :edit_booking_fields
  match 'install_books/update_new_gsk' => 'install_books#update_new_gsk', :as => 'update_new_gsk'
  
  resources :install_books
  resources :cust_infs


  # The priority is based upon order of creation:
  # first created -> highest priority.

  get 'javascripts/cust_infs' => 'javascripts#cust_infs'

  match 'utilities/save_reliance' => 'utilities#save_reliance', :as => :save_reliance
  match 'utilities/send_to_reliance' => 'utilities#send_to_reliance', :as => :send_to_reliance
  match 'utilities/monthly_report' => 'utilities#monthly_report', :as => :monthly_report
  match 'utilities/daterange_report' => 'utilities#daterange_report', :as => :daterange_report
  match 'utilities/save_report' => 'utilities#save_report', :as => :save_report
  resources :utilities  # must be after 'match'. So that Rail's RESTful be at a lower priority than the custom path

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
  root :to => "user_sessions#new"
  #root :to => "cust_infs#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
