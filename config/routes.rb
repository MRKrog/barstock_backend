Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :businesses do
        post '/register', to: 'registration#create'
        post '/login', to: 'login#create'
      end
      post '/businesses', to: 'businesses#create'
    end
  end
end
