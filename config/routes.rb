Splendor::Application.routes.draw do
  
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
  
  get "/*path" => "home#index"
  root :to => 'home#index'
end
