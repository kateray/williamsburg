Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/find', to: 'cities#get_williamsburg'
  get '/pins', to: 'user_pins#add'
  get '/all', to: 'cities#get_all'

  root to: 'cities#home'
end
