Rails.application.routes.draw do
  resources :images, only: [:create, :update, :destroy]
  get 'signed_image_url', to: 'images#signed_image_url'
  resources :transactions, except: [:update, :destroy]
  resources :items, except: :index
  resources :collections do
    resources :images, module: 'collections', only: [:create, :index]
    resources :items, module: 'collections', only: [:create, :index]
  end
  mount_devise_token_auth_for 'User', at: 'auth'
  post 'paypal/create', to: 'paypal#create_payment'
  post 'paypal/execute', to: 'paypal#execute_payment'
  get 'profile', to: 'profile#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
