Rails.application.routes.draw do
  ## Devise Authentication
  devise_for :users, only: []
  devise_scope :user do
    post   'sessions' => 'sessions#create'
    delete 'sessions' => 'sessions#destroy'
    
    get    'confirmations' => 'confirmations#show'
    post   'confirmations' => 'confirmations#create'
  end
  
  
  ## Ember
  # root to: 'home#index'
  
  
  ## User, UserFollower, Education, Experience, School
  resources :schools, only: [:index, :create, :show, :update, :destroy]
  resources :educations, only: [:index, :create, :show, :update, :destroy]
  resources :experiences, only: [:index, :create, :show, :update, :destroy]
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :followers, only: [:index, :create, :destroy], controller: :user_followers
    resources :following, only: [:index                   ], controller: :user_following
  end
  
  
  ## Community, CommunityMember, Resource, Category
  resources :resources, only: [:index, :create, :show, :update, :destroy]
  resources :categories, only: [:show]
  resources :communities, only: [:index, :create, :show, :update, :destroy] do
    resources :members, only: [:index, :create, :update, :destroy], controller: :community_members
  end
  
  
  ## Team, TeamMember, Kpi, SuccessMetric, MetricChange
  resources :kpis, only: [:index, :create, :show, :update, :destroy]
  resources :success_metric, only: [:index, :create, :show, :update, :destroy]
  resources :metric_change, only: [:index, :create, :show, :update, :destroy]
  resources :teams, only: [:index, :create, :show, :update, :destroy] do
    resources :members, only: [:index, :create, :update, :destroy], controller: :team_members
  end
  
  
  ## Listing, ListingMember
  resources :listings, only: [:index, :create, :show, :update, :destroy] do
    resources :members, only: [:index, :create, :update, :destroy], controller: :listing_members
  end
  
  
  ## Thread, Message
  resources :threads, only: [:index, :create, :show, :update, :destroy]
  resources :messages, only: [:index, :create, :show, :update, :destroy]
  
  
  ## Tag
  
  
  ## File
  resources :files, only: [:index, :create, :show, :update, :destroy]
  
  
  ## Handle
  resources :handles, only: [:index, :show]
  
  
  ## Request
  resources :requests, only: [:index, :create, :show, :update, :destroy]
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
