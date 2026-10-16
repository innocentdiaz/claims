Rails.application.routes.draw do
  resources :items, only: %i[index create]
  resources :claims, only: %i[new create show]
  root "items#index"
end
