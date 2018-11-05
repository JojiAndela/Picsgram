Rails.application.routes.draw do

  get 'share/users'
  resources :chatrooms do
  resource :chatroom_users
  resources :messages
end
resources :notifications do
    collection do
      post :mark_as_read
    end
  end
resources :direct_messages

  get ':username/followers', to: 'profile#followers', as: :profile_followers
  get ':username/following', to: 'profile#following', as: :profile_following

  match 'like', to: 'likes#like', via: :post
  match 'unlike', to: 'likes#unlike', via: :delete

  resources :pics do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  devise_for :users

  resources :relationships,       only: [:create, :destroy]

  resources :friends, only: %i[index destroy]
    resources :friend_requests, except: %i[edit new]


get ':username', to: 'profile#show', as: :profile
  root to: "pics#index"
end
