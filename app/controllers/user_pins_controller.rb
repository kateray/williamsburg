class UserPinsController < ApplicationController

	def add
		#Authentication
		if params[:aid] != ENV["APP_ID"]
			render :json => {error: "Unauthenticated request"}, :status => :unprocessable_entity
			return false
		end

		device_id = params[:did]
		lat = params[:lt].to_f
		long = params[:lg].to_f

		@city = City.near([lat, long], 50).first
		if @city.blank?
			result = Geocoder.search(lat.to_s + ',' + long.to_s, :params => {"inclnb" => 1, "IncludeEntityTypes"=>"Neighborhood"}).first
			if result && result.city && result.data['address']
				@city = City.create(name: result.city, latitude: lat, longitude: long, neighborhood: result.data['address']['neighborhood'])
				@pin = UserPin.create(token: device_id, latitude: lat, longitude: long, city_id: @city.id, neighborhood: result.data['address']['neighborhood'])
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
