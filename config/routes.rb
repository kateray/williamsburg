Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/williamsburg/:name', to: 'cities#get_williamsburg'
  get '/new', to: 'user_pins#add'

  root to: 'cities#home'
end
