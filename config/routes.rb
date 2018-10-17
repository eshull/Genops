Rails.application.routes.draw do
  resources :configurations
  resources :system_links
  resources :system_nodes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
