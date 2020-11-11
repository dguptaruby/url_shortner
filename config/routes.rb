Rails.application.routes.draw do
  resources :links, except: :show
  get '/:slug', to: 'links#show', as: :short
  root 'links#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
