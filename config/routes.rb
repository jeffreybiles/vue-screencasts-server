Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    resources :videos
    resources :video_tags, only: [:create]
    post 'video_tags/delete', to: 'video_tags#delete'
    resources :tags, only: [:index, :show, :create]
    resources :users, only: [:index, :create, :show]
    resources :sessions, only: [:create, :destroy]
    resources :video_plays, only: :create
  end
end
