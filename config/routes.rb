Rails.application.routes.draw do
  resources :images
  get 'signed_image_url', to: 'images#signed_image_url'
  resources :transactions
  resources :items
  resources :collections
  mount_devise_token_auth_for 'User', at: 'auth'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
