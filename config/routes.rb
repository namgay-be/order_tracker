Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#index'
  scope 'api/v1' do
    devise_for :users, controllers: {
      sessions: 'api/v1/sessions',
      passwords: 'api/v1/passwords',
      invitations: 'api/v1/invitations'
    }, defaults: { format: :json }
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :seeds do
        get :auto_complete, on: :collection
        get :list, on: :collection
        post :export, on: :collection
      end
      resources :seed_infos, only: :index
      resources :collection_infos, only: :index
      resources :cultivation_infos, only: :index
      resources :donor_infos, only: :index
      resources :donor_field_infos, only: :index
      resources :repatriation_infos, only: :index
      resources :locations, only: :index
      resources :foreign_seeds
      resources :test_details
      resources :gene_banks
      resources :users do
        member do
          put :soft_delete
        end
      end
      resources :customers do
        get :auto_complete, on: :collection
      end
      resources :distribution_infos
    end
  end
end
