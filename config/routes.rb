Rails.application.routes.draw do
  resources :ebidta
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks" }
  get '/profile' => 'home#profile', as: :profile
  get '/sellers' => 'home#sellers', as: :sellers
  get '/raise_capital' => 'home#raise_capital', as: :raise_capital
  get '/resources' => 'home#resources', as: :resources
  root to: "home#index"
  resources :businesses, only: [:index, :show]
  resources :campaigns
  namespace :admin do
   resources :businesses
   resources :campaigns
   resources :industries
   resources :revenues
  end
end

