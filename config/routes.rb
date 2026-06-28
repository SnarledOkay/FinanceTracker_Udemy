Rails.application.routes.draw do
  resources :user_stocks, only: [ :create, :destroy ]
  resources :friendships, only: [ :create, :destroy ]
  devise_for :users
  resources :users, only: [ :show ]
  root "pages#home"
  get "about", to: "pages#about"
  get "my-portfolio", to: "users#my_portfolio"
  post "search-stock", to: "stocks#search", as: "search_stock"
  get "my-friends", to: "users#my_friends"
  post "search-friend", to: "users#search"
end
