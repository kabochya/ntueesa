Rails.application.routes.draw do

  root 'book/user_sessions#new'
  scope module: :book, as: :book do
    root 'user_sessions#new'
    get 'login' => 'user_sessions#new',as:'new_login'
    post 'login' => 'user_sessions#create', as:'login'
    get 'logout' => 'user_sessions#destroy', as: 'logout'
    get 'shop' => 'products#index', as: 'shop'
    get 'closed' => 'application#closed'
    get 'prohibited' => 'application#prohibited'
    resource :ntueesa_book_admin, controller: :admins,as: :admin, except: :new do
      collection do
        get 'login', to: 'admins#new'
        post 'department', to: 'admins#create_dept'
        post 'users', to: 'admins#import_users'
        post 'books', to: 'admins#import_books'
        get 'dept_change_phase', to: 'admins#dept_edit_phase'
        put 'dept_change_phase/:id', to: 'admins#dept_update_phase', as: 'update_dept_phase'
        put 'dept_end_current_stage/:id', to: 'admins#dept_end_current_stage', as: 'end_current_stage'
      end
    end
    resources :users, only:[:show] do
      member do
        put 'member', to: 'users#modify_membership'
        get 'list', to: 'users#book_list'
        #put 'purchases', to: 'purchases#status_all', as:'purchases_all'
        put 'purchase/:purchase_id', to: 'purchases#status', as: 'purchases'
      end
    end
    post 'purchases' => 'products#purchase'
    delete 'unpurchase/:id' => 'products#unpurchase', as: 'purchase'
    #resources :purchases, only:[:create,:destroy]
    resource :department do
      collection do
        get 'payments'
        get 'users'
      end
    end
    # resource :user_sessions, only:[:create,:destroy,:new]
    resources :payments, only:[:show,:index,:destroy] do
      member do
        get 'checkout'
        post 'confirm', to: 'payments#pay'
        put 'confirm', to: 'payments#modify_code'
        get 'confirm' 
      end
    end
    devise_for :departments, :controllers => { :sessions => "book/sessions" },path: 'department' ,path_names: {sign_in: 'login',sign_out: 'logout'}

  end
  #root 'home#index'
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
