Rails.application.routes.draw do

  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :chat_app
  devise_for :users
  resources :users do
    member do
      get :friends
      get :followers
      get :deactivate
    end
  end
  resources :events, except: [:edit, :update]

  authenticated :user do
    root to: 'home#index', as: 'home'
  end

  unauthenticated :user do
    root 'home#front'
  end

  # unauthenticated :user do
  #   devise_scope :user do
  #     get "/" => "devise/sessions#new"
  #   end
  # end

  resources :conversations do
    resources :messages
  end


  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get
end
