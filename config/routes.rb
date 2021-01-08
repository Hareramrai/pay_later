Rails.application.routes.draw do
  resources :transactions
  resources :user_accounts
  resources :users
  resources :merchant_discounts
  resources :merchants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
