Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  devise_for :users
  get "search" => "searches#search", as: "search"

  resources :groups do
    resources :group_users, only:[:create, :destroy]
  end

  resources :books do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :index, :update] do
    resource :relationships, only: [:create, :destroy]
    get "/relationships/follows" => "relationships#follows", as: "follows"
    get "/relationships/followers" => "relationships#followers", as: "followers"
  end

  resources :messages, only:[:create]
  resources :rooms, only:[:create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
