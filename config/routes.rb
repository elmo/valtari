Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks" }
  get '/profile' => 'home#profile', as: :profile
  root to: "home#index"
  resources :businesses, only: [:index, :show]
  namespace :admin do
   resources :businesses
  end
end
