Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    resources :videos, only: [:index, :show]
    resources :tags, only: [:index, :show]
  end
end
