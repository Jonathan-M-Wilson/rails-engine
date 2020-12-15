Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do


      namespace :items do
        get '/:id/merchants', to: 'merchants#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end


      resources :merchants, only: [:index, :show, :create, :update, :destroy]

      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
