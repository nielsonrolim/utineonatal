Rails.application.routes.draw do

  devise_for :users



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  get 'home/index'
  get 'visits/index'
  get 'beds/list' => 'beds#list', as: :beds_list
  get 'beds/vacate/:bed_id' => 'beds#vacate', as: :vacate_bed
  get 'bed_history/:bed_id' => 'visits#bed_history', as: :bed_history
  get 'patient_history/:patient_id' => 'visits#patient_history', as: :patient_history
  get 'visit/details/:id' => 'visits#details', as: :visit_details
  get 'visit/indicators/:bed_id' => 'visits#indicators', as: :visit_indicators
  post 'visit/diagnoses/:bed_id' => 'visits#diagnoses', as: :visit_diagnoses
  post 'visit/interventions/:bed_id' => 'visits#interventions', as: :visit_interventions
  post 'visit/finish/:bed_id' => 'visits#finish', as: :visit_finish

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :interventions

  resources :diagnoses

  resources :indicators

  resources :indicator_categories

  resources :beds

  resources :patients

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
