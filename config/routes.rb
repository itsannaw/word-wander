Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :comments
  resources :posts

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'custom_registrations'
  }

  get "up" => "rails/health#show", as: :rails_health_check

  root "admin/dashboard#index"
end
