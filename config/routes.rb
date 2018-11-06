Rails.application.routes.draw do
  root to: "system_nodes#index"

  # resources :system_links
  # resources :system_nodes
  resources :system_nodes do
    resources :system_links
    resources :settings
  end

  resources :system_links do

  end

  post '/system_nodes/:id/targets', to: 'system_nodes#add_target'

  post '/system_nodes/:id/sources', to: 'system_nodes#add_source'

  get '/system_nodes/:id/graph', to: 'system_nodes#graph_viz'
  get '/system_nodes/:id/d3', to: 'system_nodes#d3'
  # get "/status" => 'systemNodes#graph_viz', as: 'status'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
