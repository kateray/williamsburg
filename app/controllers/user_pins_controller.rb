class UserPinsController < ApplicationController

	def add
		#Authentication
		if params[:aid] != ENV["APP_ID"]
			render :json => {error: "Unauthenticated request"}, :status => :unprocessable_entity
			return false
		end

		device_id = params[:did]
		name = params[:c].downcase
		@city = City.find_or_create_by(name: name)

		@pin = @city.user_pins.find_by_token(device_id) || UserPin.create(token: device_id)
		@pin.latitude = params[:lt].to_f
		@pin.longitude = params[:lg].to_f
		@pin.neighborhood = params[:n].downcase
		@pin.city_id = @city.id

		if @pin.save
			@city.calculate_location
			head :ok
		else
			render :json => {error: "Unable to save"}, :status => :unprocessable_entity
			return false
		end
	end

end
