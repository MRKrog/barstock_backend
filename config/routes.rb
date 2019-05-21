Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      post '/orders', to: 'orders#create'
      namespace :businesses do
        post '/register', to: 'registration#create'
        post '/login', to: 'login#create'
      end
      namespace :distributors do
        post '/login', to: 'login#create'
      end
    end
  end
end
