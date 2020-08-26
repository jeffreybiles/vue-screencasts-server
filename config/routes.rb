Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    resources :videos
    resources :video_tags, only: [:create]
    post 'video_tags/delete', to: 'video_tags#delete'
    resources :tags, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:index, :create, :destroy, :update]
    put 'users/:id/update_nonsensitive', to: 'users#update_nonsensitive'
    get 'email_preferences/status', to: 'email_preferences#status'
    post 'email_preferences/change_subscription', to: 'email_preferences#change_subscription'
    post 'email_preferences/create_and_tag', to: 'email_preferences#create_and_tag'
    get 'users/:id/:email_subscription_token', to: 'users#get_user_from_token'
    post 'users/:id/:email_subscription_token', to: 'users#update_email_subscriptions_from_token'
    resources :sessions, only: [:create, :destroy]
    get 'sessions/user', to: 'sessions#user'
    resources :video_plays, only: :create
    resources :courses
    post 'courses/:id/attach-video/:video_id', to: "courses#attach_video"
    post 'courses/:id/attach-chapter/:chapter_id', to: "courses#attach_chapter"
    post 'courses/:id/detach-video/:video_id', to: "courses#detach_video"
    post 'courses/:id/detach-chapter/:chapter_id', to: "courses#detach_chapter"
    post 'stripe/create_subscription', "stripe#create_subscription"
    get 'stripe/user_info', "stripe#user_info"
    post 'stripe/cancel_subscription', "stripe#cancel_subscription"
    post 'stripe/resubscribe', "stripe#resubscribe"
    post 'stripe/change_card', "stripe#change_card"

    resources :training_modules
    resources :training_sections
    resources :training_items
    resources :training_completions, only: :create

    resources :training_users, only: [:index, :create]

    post 'hooks/new_training_customer', "hooks#new_training_customer"
  end
end
