Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do


      namespace :items do
        get '/:id/merchant', to: 'merchants#index'
      end


      resources :merchants, only: [:index, :show]

      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
