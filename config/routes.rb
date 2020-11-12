Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :links, except: :show
  get '/:slug', to: 'links#show', as: :short
  root 'links#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
