class UserPinsController < ApplicationController

	def add
		#Authentication
		if !params[:aid] || params[:aid] != '1413358A-9CE6-4E27-A142-4A2AE4AF20A2'
		# if params[:aid] != ENV["APP_ID"]
			render :json => {error: "Unauthenticated request"}, :status => :unprocessable_entity
			return false
		end

		device_id = params[:did]
		lat = params[:lt].to_f
		long = params[:lg].to_f

		@city = City.near([lat, long], 50).first

		if @city == nil
			result = Geocoder.search(lat.to_s + ',' + long.to_s).first
			if result && result.city
				@city = City.create(name: result.city, latitude: lat, longitude: long)
				@pin = UserPin.create(token: device_id, latitude: lat, longitude: long, city_id: @city.id)
				head :ok
			else
				render json: {error: "Unable to save"}, :status => :unprocessable_entity
				return false
			end
		else
			@pin = @city.user_pins.find_by_token(device_id) || UserPin.create(token: device_id)
			@pin.latitude = lat
			@pin.longitude = long
			@pin.city_id = @city.id

			if @pin.save
				@city.calculate_location
				head :ok
			else
				render json: {error: "Unable to save"}, :status => :unprocessable_entity
				return false
			end

		end
	end

end
