Rails.application.routes.draw do
  resources :user_stocks, only: [ :create, :destroy ]
  devise_for :users
  root "pages#home"
  get "about", to: "pages#about"
  get "my-portfolio", to: "users#my_portfolio"
  post "search-stock", to: "stocks#search", as: "search_stock"
end
