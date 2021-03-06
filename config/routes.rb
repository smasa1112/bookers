Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  devise_for :users, controllers:{
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  get "search" => "searches#search", as: "search"
  get "number_of_post" => "searches#get_number_of_post", as:"number_of_post"

  resources :groups do
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
    resource :group_users, only:[:create, :destroy]
  end

  resources :books do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get :detail_search
      get :detail_search_result
    end
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
