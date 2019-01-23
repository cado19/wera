class SubdomainPresent
	def self.matches?(request)
		request.subdomain.present? && request.subdomain != 'www'
	end
end

class SubdomainBlank
  def self.matches(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do


###################################### Routes for presence of subdomain/account #########################################
	constraints(SubdomainPresent) do
		################## #Admin Routes ##################################################
  		namespace :admin do
  		    resources :categories do
            collection do
              match 'search' => 'categories#search', via: [:get, :post], as: :search
            end
          end

					resources :customers do
            collection do
              match 'search' => 'customers#search', via: [:get, :post], as: :search
            end
          end

  		    resources :sales do
            collection do
              match 'search' => 'sales#search', via: [:get, :post], as: :search
            end
          end
					get 'products/available', to: 'products#available', as: 'available_products'
					get 'products/unavailable', to: 'products#unavailable', as: 'unavailable_products'
  		    resources :products do
            collection do
              match 'search' => 'products#search', via: [:get, :post], as: :search
            end
          end

          resources :suppliers do
            collection do
              match 'search' => 'suppliers#search', via: [:get, :post], as: :search
            end
          end
  		    resources :purchases
          resources :users
          get '/my_account', to: 'dashboard#show'
          get 'highest_selling/highest_selling'

					root to: 'dashboard#index'
  	    end
    ################### END ADMIN ROUTES #############################################

    ######## Routes for Sessions Controller ###############
    resources :users
    get '/signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
		resources :owners


    #############################################################################
    get 'home/index'
    resources :sales do
    	resources :customers
    end
    resources :sale_items, only: [:new, :create, :show, :update, :destroy]
    resources :carts #, only: [:new, :create, :show]
		get 'products/available' => 'products#available', as: 'available_products'
		resources :products, only: [:index, :show]

    resources :categories, only: [:index, :show]
		resources :catalog
    resources :password_resets
    root to: 'home#index'
  end
  ################################ END DOMAIN ROUTES #########################################

  ##################### Routes for absence of subdomain/account ######################################
    get 'welcome/home'
    get 'welcome/policy'
    resources :contacts, only: [:new, :create]
    root 'welcome#home'
    resources :accounts, only: [:new, :create]
		resources :posts, only: [:index, :show]
    ####### Routes for maintenance sessions ###########################################################
    get '/maintenance_login', to: 'maintenance_sessions#new'
    post '/maintenance_login', to: 'maintenance_sessions#create'

    resources :maintenance_users
    ################### Super User Routes #############################################################
    namespace :maintenance do
      resources :accounts do
        collection do
          match 'search' => 'accounts#search', via: [:get, :post], as: :search
        end
      end

			resources :posts
      resources :contacts do
        collection do
          match 'search' => 'contacts#search', via: [:get, :post], as: :search
        end
      end
      root to: 'dashboard#index'
    end
end
