Rails.application.routes.draw do
  root 'root#index'
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/orders', to: 'orders#index'
      post '/orders', to: 'orders#create'
      post '/items', to: 'items#create'
      patch '/items/:id', to: 'items#update'
      patch '/business_items/:id', to: 'business_items#update'
      get '/business_items', to: 'business_items#index'
      get '/business_items/:id', to: 'business_items#show'
      post '/business_items', to: 'business_items#create'
      get '/cocktails/:id/', to: 'cocktails#show'
      post '/login', to: 'login#create'
      namespace :businesses do
        post '/register', to: 'registration#create'
        get '/account', to: 'account#show'
        get '/items_popularity', to: 'items_popularity#index'
      end
    end
  end
end
