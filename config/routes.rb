Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      namespace :businesses do
        post '/register', to: 'registration#create'
        post '/login', to: 'login#create'
      end
    end
  end
end
