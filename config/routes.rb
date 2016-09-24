Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/find', to: 'cities#get_williamsburg'
  get '/pins', to: 'user_pins#add'
  get '/all', to: 'cities#get_all'
  get '/cities', to: 'cities#index'
  get '/usa', to: 'user_pins#usa'
  get '/map', to: 'user_pins#map'

  root to: 'cities#home'
end
