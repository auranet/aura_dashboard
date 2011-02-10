ActionController::Routing::Routes.draw do |map|
  map.dashboard_show_dashboard ':controller/show_dashboard',
    :action => 'show_dashboard'
  map.dashboard_show_dashboard ':controller/save_dashboard',
    :action => 'save_dashboard'
  map.dashboard_show_dashboard_widget ':controller/show_widget.:format',
    :action => 'show_widget'
  map.dashboard_show_dashboard_widget ':controller/show_widget_settings.:format',
    :action => 'show_widget_settings'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
