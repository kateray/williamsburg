Rails.application.routes.draw do

  get '/williamsburg/:name', to: 'cities#get_williamsburg'

  root to: 'cities#home'
end
