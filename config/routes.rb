Paperlesspipeline::Application.routes.draw do

  post '/email_processor' => 'griddler/emails#create'
  devise_for :users

  resources :tasks do
    member do
      put :update_status
    end
  end


  resources :checklists

  resources :search do
    collection do
      get :advance_search
    end
  end

  resources :locations

  resources :users do
    member do
      get :admin
      get :manage_locations
      get :manage_users
      post :user_create
      put :activate
      get :profile
    end
    collection do
      post :user_create
      get :add_user
      post :add_role
    end
  end 
  resources :dashboard

  resources :documents do
    collection do
      get :location_search
      get :search
      get :working
      get :working_filter
      get :office
      get :unreviewed
      post :comment
      get :download_document
      post :drag_drop
    end
    member do
      post :update_reviewed
    end
    resources :comments
  end
  

  resources :transactions do
    member do
      post :create_contact
    end
    collection do
      get :location_search
      get :search
      get :advance_search
      get :transaction_advance_search
      get :filter
      get :transaction_search
      get :export_transactions
      post :add_note
      get :agents_search
      post :add_comment
      get :assign_document
      post :assign_document_to_transaction
      get :search_by_transaction_details
    end
  end

  resources :welcome do
    collection do
      post :email_update
    end
  end

  match "/documents/download_document" => 'documents#download_document',:as => 'download'

  match "/email" => 'welcome#email_update'

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
  #  root :to => 'welcome#email_update'
  # This is root for cloud9 app==============================================================
  devise_scope :user do
    root :to => "devise/sessions#new"
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
