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
      resources :users
    end
  end
end
