Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'index#index'

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
  namespace :oauth do
    resources :applications
    resources :authorize do
      get 'response_code'
    end
    resources :token
  end
  namespace :api do
    get 'users/logout'
    get 'users/get_zj'
    get 'users/get_teacher'
    get 'users/get_user'
    resources :users
    post 'kindeditor/upload'
    resources :grades
    resources :subjects
    resources :departments
    post 'im/login'
    get 'im/contacts'
    get 'im/get_group_member'
    get 'im/get_user_info'
    get 'im/get_users_by_ease_ids'
    post 'im/add_group'
    post 'im/add_friend'
    get 'units/sub_units_by_type'
    resources :units
  end

  get 'index/login'
  post 'index/checklogin'
  get 'index/upload_form'
  post 'index/upload'
  get 'index/logout'
  get 'index/forget'
  post 'index/send_pwd'
  get 'index/test_imp'

  get 'units/active'

  resources :departments
  resources :duties
  resources :units

  get 'users/set_subject'
  delete 'users/del_subject'
  post 'users/save_subject'
  get 'users/set_klass'
  delete 'users/del_klass'
  post 'users/save_klass'
  get 'users/imp_teacher'
  post 'users/imp_teacher_save'
  get 'users/imp_student'
  post 'users/imp_student_save'
  resources :users
  resources :klasses

  get 'webim', to: 'webim#index'

  mount ChinaCity::Engine => '/china_city'
end
