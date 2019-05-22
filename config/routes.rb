Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      post '/items', to: 'items#create'
      patch '/items/:id', to: 'items#update'
      get '/business_items', to: 'business_items#index'
      post '/business_items', to: 'business_items#create'
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
