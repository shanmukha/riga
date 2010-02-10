ActionController::Routing::Routes.draw do |map|
  map.root :controller => "site_pages", :action => "home"
  map.resources :orders, :new => {:express_checkout => :get}, :member =>{:confirmation => :get}
  map.with_options :controller => 'site_pages' do |s|
    s.why_riga 'why_riga', :action => 'why_riga'
    s.what_is_in_stag_guide 'what_is_in_stag_guide', :action =>'what_is_in_stag_guide'
  end

  map.resource :user_session

  map.namespace(:admin) do |admin|
    admin.resources :orders, :controller => 'orders'
  end

  map.resources :guides, :collection => {:guide => :get, :resend_guide => :get, :guide_resent => :post}
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
