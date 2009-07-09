ActionController::Routing::Routes.draw do |map|
  
  map.resources :users  

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.register '/register/:activation_code', :controller => 'activations', :action => 'create'
  map.profile '/profile', :controller => 'users', :action => 'edit'
  map.resources :activations
  map.resources :user_sessions
  map.resources :password_resets
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
