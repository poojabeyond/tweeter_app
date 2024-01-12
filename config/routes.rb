Rails.application.routes.draw do
  root to: "home#index"
get "sign_up", to: "registration#new"
post "sign_up", to: "registration#create"

get "password", to: "passwords#edit"
patch "password", to: "passwords#update"

get "password/reset", to: "password_reset#new"
post "password/reset", to: "password_reset#create"

get "password/reset/edit", to: "password_reset#edit"
patch "password/reset/edit", to: "password_reset#update"

get "sign_in", to: "sessions#new"
post "sign_in", to: "sessions#create"
delete "logout", to: "sessions#destroy"

get '/auth/twitter/callback', to: "omniauth_callbacks#twitter"

resources :twitter_accounts, only: [:index, :destroy]
resources :tweets, except: [:show]
end
