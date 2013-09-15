Campusconnect::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  match '/auth/:provider/callback' => 'users#facebook_login'
  match 'auth/failure', to: redirect('/')
  devise_for :users
  get "about_us", to: 'home#about_us', as: 'about_us'
  get "team", to: 'home#team', as: 'team'
  get "terms", to: 'home#terms', as: 'terms'
  get "privacy_policy", to: 'home#privacy_policy', as: 'privacy_policy'

  resources :home do
    collection do
      get "index"
      get "study_material"
    end
  end

  resources :users do
    member do
      get 'show_mail'
      post 'update'
    end
    collection do
      get "expert_consultancy"
      get "query"
      get "sent"
      post "create_query"
      post 'reply_mail'
      get 'account'
    end
  end

  resources :admin do
    collection  do
      get "index"
      get "study_material"
      get "mock_tests"
      get "pd_articles"
      get "expert_consultancy"
      get "campus_news"
    end
  end

  resources :student do
    collection  do
      get "index"
      get "study_material"
      get "mock_tests"
      get "pd_articles"
      get 'downloads'
      get 'test'
      get 'dream_job'
      get 'news'
    end
  end

  resources :study_materials do
    member do
      get "download"
    end

    collection do
      get "list"
    end
  end

  resources :question_papers do
    collection do
      get "list"
    end
    member do
      get 'examination'
      get 'detail'
      get 'start'
      get 'review'
      get 'test_reviewer'
      post 'test_reviewer'
      put 'test_reviewer'
      post 'test_conductor'
      get  'test_conductor'
      post 'test_submit'
      get 'test_submit'
    end
  end
  resources :pd_articles do
    member do
      get "like"
      get "unlike"
    end
    collection do
      get "list"
    end
  end
  resources :technicals do
    collection do
      get :books
      get :projects
      get :interviews
    end
  end
  resources :dreams
  resources :interviews
  resources :books
  resources :projects do
    member do
      get "apply"
    end
  end
  resources :project_applications
  resources :newses
  resources :topics
  resources :subjects

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
