Rails.application.routes.draw do
  mount PostgresqlLoStreamer::Engine => 'event_photo', as: 'event_photo'
  mount PostgresqlLoStreamer::Engine => 'asset_data', as: 'asset_data'
  mount PostgresqlLoStreamer::Engine => 'deal_room_upload', as: 'deal_room_upload'
  mount PostgresqlLoStreamer::Engine => 'user_avatar', as: 'avatar'

  mount Judge::Engine => '/judge'
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks", registrations: 'registrations' }

  root to: "home#splash"
  get '/home' => 'home#index', as: :home
  get '/knowledge' => 'home#knowledge', as: :knowledge
  get '/dashboard' => 'my/dashboard#home', as: :my_dashboard
  get '/admin' => 'admin/site#index', as: :admin
  get '/suggest' => 'suggestions#index', as: :suggest
  get '/x/:id' => 'shortener/shortened_urls#show', as: :shortened
  get '/secure/example' => 'private/cims#teaser'

  resources :businesses, only: [:index, :show]
  resources :campaigns, only: [:index,:show]
  resources :capitals, only: [:index,:show]
  resources :opportunities, only: [:index,:show]
  resources :events, only: [:index,:show]
  resources :users, only: [:show]

  namespace :my do
    resource :interests
    resources :followings
    resources :verifications, only: [:index]
    resources :businesses do
      resources :notes
      resources :user_businesses
      resources :verifications
    end
    resources :events
    resources :campaigns do
      member do
        put 'publish'
        put 'unpublish'
      end
    end
    resources :capitals
    resources :messages do
      member do
        put 'open'
      end
    end
    resources :notes, only: [:index, :show]
    resources :opportunities do
      member do
        put 'publish'
        put 'unpublish'
      end
    end
    resources :searches
  end

  namespace :admin do
   resources :activity_logs, only: [:index]
   resources :cim_inquiries, only: [:index]
   resources :divisions, only: [:index]
   resources :verifications do
      member do
        put 'complete'
      end
   end
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

  devise_scope :user do
     get "/private/sessions/new" => "private/sessions"
  end

  namespace :private  do
    resources :deal_room_uploads do
       resources :notes
    end
    resources :deal_rooms do
       resources :notes
       resources :deal_room_uploads
       resources :deal_room_invitations do
          member do
            put 'resend'
          end
       end
       resources :groups, only: [:show]
       resources :deal_room_authorizations, only: [:index, :destroy, :index]
       resources :deal_room_ndas, only: [:new,:create]
       resources :deal_room_activities, only: [:index]
       resources :deal_room_users, only: [:index, :edit, :update,:show]
    end
    resources :sessions, only: [:new, :create]
    resources :cim_inquiries, only: [:new,:create,:show]
    resources :cims do
      collection do
        get 'welcome'
        get 'teaser'
      end
      resources :cim_accesses, only: [:index]
      resources :cim_assets, only: [:new, :create, :destroy, :show]
      resources :users do
         put 'remove'
         put 'client'
         put 'remove_client'
         put 'invite'
      end
    end
  end

end

