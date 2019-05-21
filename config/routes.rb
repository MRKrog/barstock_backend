Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/business_items', to: 'business_items#index'
      namespace :businesses do
        post '/register', to: 'registration#create'
        post '/login', to: 'login#create'
        get '/account', to: 'account#show'
      end
      namespace :distributors do
        post '/login', to: 'login#create'
      end
    end
  end
end
