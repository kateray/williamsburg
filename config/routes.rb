Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/williamsburg/:name', to: 'cities#get_williamsburg'

  root to: 'cities#home'
end
