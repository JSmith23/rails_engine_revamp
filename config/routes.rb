Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get '/:id/items', to: "items#show"
        get '/:id/invoices', to: "invoices#show"
        get '/most_revenue', to: "revenue#index"
        get '/most_items', to: "most_items#index"
        get '/revenue', to: "revenue#show"
      end
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: "invoices#show"
        get '/:id/transactions', to: "transactions#show"
        get ':id/favorite_merchant', to: "favorite_merchant#show"
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/merchant', to: 'merchants#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end
      namespace :invoices do
        get '/find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/merchant', to: 'merchants#show'
        get '/:id/customer', to: 'customers#show'
        get '/:id/items', to: 'items#show'
        get '/:id/transactions', to: 'transactions#show'
      end
      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get ':id/invoice', to: 'invoices#show'
      end
      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/item', to: 'items#show'
        get '/:id/invoice', to: 'invoices#show'
      end
      resources :merchants, module: "merchants", only: [:index, :show]
      resources :customers, module: "customers", only: [:index, :show]
      resources :items, module: "items", only: [:index, :show]
      resources :invoices, module: "invoices", only: [:index, :show]
      resources :transactions, module: "transactions", only: [:index, :show]
      resources :invoice_items, module: "invoice_items", only: [:index, :show]
    end
  end
end
