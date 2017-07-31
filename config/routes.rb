Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :words, only: [:create]
      get "top_word", to: "top_word#show"
    end
  end
end

