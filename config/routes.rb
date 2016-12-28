require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == Settings.sidekiq.username && password == Settings.sidekiq.password
  end if Rails.env.production?
  mount Sidekiq::Web, at: '/sidekiq'

  concern :activeable do
    post :toggle_is_active, on: :member
  end

  # Admins
  devise_for :admins, controllers: { sessions: 'hq/sessions', registrations: 'hq/registrations', passwords: 'hq/passwords' }, path: 'hq',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',  confirmation: 'verification' }
  as :admin do
    get 'hq/edit' => 'hq/registrations#edit', as: 'edit_admin_registration'
    put 'hq' => 'hq/registrations#update', as: 'admin_registration'
  end
  namespace :hq do
    root to: 'dashboard#index'
    resources :dashboard, only: [:index]
    resources :admins, concerns: [:activeable]
    resources :users, concerns: [:activeable]
    resources :customers, concerns: [:activeable]
    resources :countries
    resources :cities
    resources :audits, only: [:index, :show]
  end
  # Users
  devise_for :users, controllers: { sessions: 'user/sessions', registrations: 'user/registrations', passwords: 'user/passwords' }, path: 'user',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',  confirmation: 'verification' }
  as :user do
    get 'user/edit' => 'user/registrations#edit', as: 'edit_user_profile_registration'
    put 'user' => 'user/registrations#update', as: 'user_profile_registration'
  end
  namespace :user do
    root to: 'dashboard#index'
    resources :dashboard, only: [:index]
    resources :profile, only: [:show, :edit, :update]
  end
  #Customers
  devise_for :customers, controllers: {sessions: 'customer/sessions', registrations: 'customer/registrations', passwords: 'customer/passwords' }, path: 'customer',
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret',  confirmation: 'verification' }
  as :customer do
    get 'customer/edit' => 'customer/registrations#edit', as: 'edit_customer_profile_registration'
    put 'customer' => 'customer/registrations#update', as: 'customer_profile_registration'
  end
  namespace :customer do
    root to: 'dashboard#index'
    resources :dashboard, only: [:index]
    resources :profile, only: [:show, :edit, :update]
    resources :orders
  end

  #products
  resources :products

  #supliers
  resources :supliers

  #stocks
  resources :stocks

  # Common pages
  root to: 'welcome#index'

  if Rails.env.production? or Rails.env.staging?
    match '*unmatched_route', to: 'application#page_not_found', via: :all
  end

end
