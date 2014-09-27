Splendor::Application.routes.draw do
  root :to => 'home#index'
  get "home/index"

  devise_for :users, :path_prefix => 'api/v1', skip: :all
  devise_scope :user do
    get 'confirm_account' => 'confirmations#show', :as => :confirmation, :format => false
  end

  namespace :api, :format => false, :defaults => {:format => 'json'} do
    namespace :v1 do
      devise_scope :user do
        post 'login' => 'sessions#create', :as => :login
        delete 'logout' => 'sessions#destroy', :as => :logout
        post 'register' => 'registrations#create', :as => :registers
        delete 'delete_account' => 'registrations#destroy', :as => :delete_account
        post 'reconfirm_account' => 'confirmations#create', :as => :reconfirm
      end
      resources :games, only: [:index, :show, :create], shallow: true do
        resources :players, only: [:create, :destroy], shallow: true do
          post 'moves' => 'players#make_move'
        end
      end
    end
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
