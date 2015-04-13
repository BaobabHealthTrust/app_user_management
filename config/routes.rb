Rails.application.routes.draw do

 root 'core_user_management#select_user_task'

 get '/login' => 'core_user_management#login'

 get '/new_user' => "core_user_management#new_user"

 get '/edit_user_status/:id' => "core_user_management#edit_user_status"

 get '/edit_user_status' => "core_user_management#edit_user_status"

 post  '/create_user' => "core_user_management#create_user"

 get '/user_list' => "core_user_management#user_list"

 get '/select_user_task' => "core_user_management#select_user_task"

 post '/update_user_status' => "core_user_management#update_user_status"

 get  '/edit_roles' => "core_user_management#edit_roles"

 post '/add_user_roles' => "core_user_management#add_user_roles"

 get '/void_role' => "core_user_management#void_role"

 get '/edit_user' => "core_user_management#edit_user"

 post '/update_user' => "core_user_management#update_user"

 get '/edit_password' => "core_user_management#edit_password"

 post '/update_password' => "core_user_management#update_password"

 post '/authenticate' => "core_user_management#authenticate"

 get '/logout/:id' => "core_user_management#logout"

 get  '/verify/:id' => "core_user_management#verify"

 post '/location' => "core_user_management#location"

 get '/location' => "core_user_management#location"

 post '/location_update' => "core_user_management#location_update"

 get '/location_update' => "core_user_management#location_update"

 get '/user_demographics' => "core_user_management#user_demographics"

 get '/remote_login' => "core_user_management#remote_login"

 get '/remote_logout' => "core_user_management#remote_logout"

 get '/remote_authentication' => "core_user_management#remote_authentication"

 post '/remote_login' => "core_user_management#remote_login"

 post '/remote_logout' => "core_user_management#remote_logout"

 post '/remote_authentication' => "core_user_management#remote_authentication"

 get '/get_wards' => "core_user_management#get_wards"

 get '/get_user_names' => "core_user_management#get_user_names"

 post '/get_wards' => "core_user_management#get_wards"

 post '/get_user_names' => "core_user_management#get_user_names"

 post '/update_credentials' => "core_user_management#update_credentials"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
