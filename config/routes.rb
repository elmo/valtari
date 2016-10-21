Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks" }
  get '/profile' => 'home#profile', as: :profile
  get '/sellers' => 'home#sellers', as: :sellers
  get '/raise_capital' => 'home#raise_capital', as: :raise_capital
  get '/resources' => 'home#resources', as: :resources
  get '/admin' => 'admin/site#index', as: :admin
  root to: "home#profile"
  resources :businesses, only: [:index, :show]
  resources :campaigns, only: [:index,:show]
  namespace :my do
   resources :campaigns
  end

  namespace :admin do
   resources :businesses
   resources :ebidtas
   resources :campaigns
   resources :industries
   resources :revenues
  end
end

