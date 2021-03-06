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
  get 'beds/new_hospitalization/:bed_id' => 'beds#new_hospitalization', as: :new_hospitalization
  get 'beds/new_hospitalization_additional/:bed_id/:patient_id' => 'beds#new_hospitalization_additional', as: :new_hospitalization_additional
  get 'beds/new_patient/:bed_id' => 'patients#new', as: :bed_new_patient
  post 'beds/create_hospitalization/:bed_id/:patient_id' => 'beds#create_hospitalization', as: :beds_create_hospitalization
  get 'bed_history/:bed_id' => 'visits#bed_history', as: :bed_history
  get 'patient_history/:patient_id' => 'hospitalizations#index', as: :hospitalizations
  get 'hospitalizations/:id' => 'hospitalizations#show', as: :hospitalization
  get 'patient_visits/:patient_id' => 'visits#patient_history', as: :patient_visit_history
  get 'visit/details/:id' => 'visits#details', as: :visit_details
  get 'visit/details/:id.pdf' => 'visits#details', as: :visit_details_pdf
  get 'visit/new/:bed_id' => 'visits#new', as: :visit_new
  get 'visit/physical_examination/:bed_id' => 'visits#physical_examination', as: :physical_examination
  get 'visit/indicators/:bed_id' => 'visits#indicators', as: :visit_indicators
  post 'visit/indicators/:bed_id' => 'visits#indicators', as: :visit_indicators_post
  get 'visit/interventions/:bed_id' => 'visits#interventions', as: :visit_interventions_get
  get 'cancel_visit/' => 'visits#cancel_visit', as: :cancel_visit
  post 'visit/diagnoses/:bed_id' => 'visits#diagnoses', as: :visit_diagnoses
  get 'visit/diagnoses/:bed_id' => 'visits#diagnoses', as: :visit_diagnoses_get
  post 'visit/interventions/:bed_id' => 'visits#interventions', as: :visit_interventions
  post 'visit/finish/:bed_id' => 'visits#finish', as: :visit_finish
  get 'visit/finish/:bed_id' => 'visits#finish', as: :visit_finish_get
  post 'patient_search' => 'patients#search', as: :patient_search
  get 'patient_search/:page' => 'patients#search', as: :patient_search_paginate

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :interventions

  resources :diagnoses

  resources :indicators

  resources :indicator_categories

  resources :beds

  resources :patients

  resources :users

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
