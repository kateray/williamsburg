Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/find', to: 'cities#get_williamsburg'
  get '/pins', to: 'user_pins#add'

  root to: 'cities#home'
end
