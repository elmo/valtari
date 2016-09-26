Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: "callbacks" }
  get '/profile' => 'home#profile', as: :profile
  root to: "home#index"
end
