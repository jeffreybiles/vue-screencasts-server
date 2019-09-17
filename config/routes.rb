Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    resources :videos, only: [:index, :show, :create, :updae, :destroy]
    resources :tags, only: [:index, :show]
    resources :users, only: [:index]
  end
end
