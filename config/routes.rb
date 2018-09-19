Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'messages#new'

  resource :session, only: [:new, :create, :destroy]
  resource :user
  

  get 'messages', to: 'messages#new'
  post 'messages', to: 'messages#create'
  get '/:token', to: 'messages#password', as: 'password'
  post '/:token', to: 'messages#show'
end
