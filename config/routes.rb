Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resource :items, only: [:index, :new, :show, :edit]
end
