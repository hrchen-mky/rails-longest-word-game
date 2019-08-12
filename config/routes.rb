Rails.application.routes.draw do
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/new", to: "pages#new", as: "new"
  post "/old", to: "pages#old"
  # post"/new", to: "pages#new", as: "new"
  # get "/old", to: "pages#old"
end
