Rails.application.routes.draw do
  # HTML blog
  resources :posts
  root "posts#index"

  # JSON API
  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end
