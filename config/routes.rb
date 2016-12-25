Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks", registrations: 'registrations' }
  get '/profile' => 'home#profile', as: :profile
  get '/sellers' => 'home#sellers', as: :sellers
  get '/raise_capital' => 'home#raise_capital', as: :raise_capital
  get '/resources' => 'home#resources', as: :resources
  get '/admin' => 'admin/site#index', as: :admin
  root to: "home#profile"

  resources :businesses, only: [:index, :show]
  resources :campaigns, only: [:index,:show]
  resources :capitals, only: [:index,:show]
  resources :users, only: [:show]

  namespace :my do
    resources :campaigns
    resources :capitals
    resources :businesses do
      resources :user_businesses
    end
  end

  namespace :admin do
   resources :businesses
   resources :campaigns
   resources :capitals
   resources :company_types
   resources :ebidtas
   resources :geos
   resources :industries
   resources :organizations
   resources :sic_codes
   resources :revenues
  end
end

