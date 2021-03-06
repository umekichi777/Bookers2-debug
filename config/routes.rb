Rails.application.routes.draw do
  get 'chats/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    resources :event_notices, only: [:create, :new]
    get 'event_notices' => 'event_notices#sent'
  end

  resources :chats, only: [:create]
  get 'chat/:id' => 'chats#show', as: 'chat'


  get 'search' => 'searches#search'


  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
