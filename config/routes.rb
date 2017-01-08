Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks", registrations: 'registrations' }
  get '/profile' => 'my/dashboard#home', as: :profile
  get '/sellers' => 'home#sellers', as: :sellers
  get '/raise_capital' => 'home#raise_capital', as: :raise_capital
  get '/resources' => 'home#resources', as: :resources
  get '/admin' => 'admin/site#index', as: :admin
  root to: "my/dashboard#home"

  resources :businesses, only: [:index, :show]
  resources :campaigns, only: [:index,:show]
  resources :capitals, only: [:index,:show]
  resources :opportunities, only: [:index,:show]
  resources :events, only: [:index,:show]
  resources :users, only: [:show]

  namespace :my do
    resources :businesses do
      resources :notes
      resources :user_businesses
    end
    resources :events
    resources :campaigns
    resources :capitals
    resources :messages do
      member do
        put 'open'
      end
    end
    resources :notes, only: [:index, :show]
    resources :opportunities
    resources :searches
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

