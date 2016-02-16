Rails.application.routes.draw do

  

  resources :admin_tables

  resources :banks

  

  resources :initsettings
  
  # get 'users/:id/edit' => 'users#edit'
  # post 'users/:id/edit', to: 'users#create'
  
  root to: 'visitors#index'
  # devise_for :users, :path_prefix => 'my'
  # resources :users, :only => [:new, :show, :create]
  
  devise_for :users, :path_prefix => 'my'
    resources :users
  
  #resources :users, :only => [:new, :edit, :create, :delete, :update]
  resources :exp_imps
  resources :gst_returns
  resources :gst_return
  
  get 'visitors/main_menu', as: 'Main_menu' 
  get 'visitors/adminservice', as: 'Admin_service'
  get 'visitors/index_rus', as: 'index_rus'
  get 'visitors/contacts' => 'visitors#contacts'
  # get 'visitors/inits' => 'visitors#inits'
  get 'transactions/update_codes', as: 'update_codes'
  get 'transactions/:id/update_codes' => 'transactions#update_codes'
  get 'temp_transactions/update_cur_codes', as: 'update_cur_codes'
  get 'temp_transactions/:id/update_cur_codes' => 'temp_transactions#update_cur_codes'
  get 'future_transactions/update_curf_codes', as: 'update_curf_codes'
  get 'future_transactions/:id/update_curf_codes' => 'future_transactions#update_curf_codes'
  get 'transactions/gst_return' => 'transactions#gst_return'
  get 'transactions/tax_return' => 'transactions#tax_return'
  get 'future_transactions/compact' => 'future_transactions#compact'
  get 'transactions/gst_return' => 'transactions#gst_return'
  get 'transactions/tax_return' => 'transactions#tax_return'
  get 'transactions/show'
  get 'transactions/index'
  get 'transactions/new'
  get 'transactions/create'
  get 'gst_return/display' => 'gst_return#display' 
  get 'transferings', to: 'transferings#new'
  post 'transferings', to: 'transferings#create', :as => 'transfer_excel_data'
  get 'reallocate', to: 'reallocate#new'
  post 'reallocate', to: 'reallocate#create', :as => 'reallocate_data'
  get 'main_menu_help', to: 'helps#main_menu'
  get 'main_menu_rus_help', to: 'helps#main_menu_rus'
  post 'employees/:id/make_payment', to: 'employees#create', :as => 'employee_make_payment'
  get 'charts/indexfull', to: 'charts#indexfull'
  get 'transactions/indexfull', to: 'transactions#indexfull'
  get 'temp_transactions/indexfull', to: 'temp_transactions#indexfull'
  get 'temp_transactions/clean_up', to: 'temp_transactions#clean_up'
  get 'future_transactions/indexfull', to: 'future_transactions#indexfull'
  get 'employees/indexfull', to: 'employees#indexfull'
  resources :employees do
    member do
      get 'make_payment'
    end
  end
  resources :datesettings
  resources :charts
  resources :employees 
  resources :transactions
  resources :temp_transactions 
  resources :future_transactions
  resources :future_transactions, :collection => {:complete => 'put'}
  resources :temp_transactions, :collection => {:complete => 'put'}
  
end
