Rails.application.routes.draw do
  mount PostgresqlLoStreamer::Engine => 'event_photo', as: 'event_photo'
  mount Judge::Engine => '/judge'
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks", registrations: 'registrations' }
  root to: "home#splash"
  get '/home' => 'home#index', as: :home
  get '/profile' => 'my/dashboard#home', as: :profile
  get '/admin' => 'admin/site#index', as: :admin

  resources :businesses, only: [:index, :show]
  resources :campaigns, only: [:index,:show]
  resources :buysides, only: [:index,:show]
  resources :capitals, only: [:index,:show]
  resources :opportunities, only: [:index,:show]
  resources :events, only: [:index,:show]
  resources :users, only: [:show]

  namespace :my do
    resource :interests
    resources :buysides
    resources :followings
    resources :businesses do
      resources :notes
      resources :user_businesses
      resources :verifications
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
   resources :activity_logs, only: [:index]
   resources :divisions, only: [:index]
   resources :verifications
   resources :businesses do
     put 'dupe'
     put 'undupe'
     collection do
       get 'export'
     end
   end
   resources :campaigns
   resources :capitals
   resources :company_types
   resources :ebidtas
   resources :events
   resources :geos
   resources :industries
   resources :organizations
   resources :sic_codes
   resources :revenues
  end
end

