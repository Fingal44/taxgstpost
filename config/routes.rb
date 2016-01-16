Rails.application.routes.draw do

  

  resources :admin_tables

  resources :banks

  resources :datesettings

  resources :initsettings

  root to: 'visitors#index'
  devise_for :users
    resources :users, :only => [:index, :show]
  
  resources :charts
  
  resources :exp_imps
  
  # resources :rus_messages
  resources :gst_returns
  resources :gst_return
  
  get 'visitors/main_menu', as: 'Main_menu'
  get 'visitors/adminservice', as: 'Admin_service'
  get 'visitors/index_rus', as: 'index_rus'
  get 'visitors/contacts' => 'visitors#contacts'
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
  get 'transfer_data', to: 'transfer_data#new'
  post 'transfer_data', to: 'transfer_data#create', :as => 'transfer_excel_data'
  get 'reallocate', to: 'reallocate#new'
  post 'reallocate', to: 'reallocate#create', :as => 'reallocate_data'
  post 'employees/:id/make_payment', to: 'employees#create', :as => 'employee_make_payment'
  resources :employees do
    member do
      get 'make_payment'
    end
  end
  
  resources :employees 
  resources :transactions
  resources :temp_transactions 
  resources :future_transactions
  resources :future_transactions, :collection => {:complete => 'put'}
  resources :temp_transactions, :collection => {:complete => 'put'}
  
end
