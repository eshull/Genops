Rails.application.routes.draw do
  root to: "system_nodes#index"
  resources :configurations
  # resources :system_links
  # resources :system_nodes
  resources :system_nodes do
    resources :system_links
  end

  post '/system_nodes/:id/targets', to: 'system_nodes#add_target'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
