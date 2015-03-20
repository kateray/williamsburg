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

		result = Geocoder.search(lat.to_s + ',' + long.to_s, :params => {"inclnb" => 1, "IncludeEntityTypes"=>"Neighborhood"}).first

		if result && result.city && result.data['address']
			city = result.city
			neighborhood = result.data['address']['neighborhood']
		end

		if @city
			@pin = @city.user_pins.find_by_token(device_id) || UserPin.create(token: device_id, city_id: @city.id)
			if neighborhood
				@pin.neighborhood = neighborhood
			end
			@pin.latitude = lat
			@pin.longitude = long

			if @pin.save
				@city.calculate_location
				head :ok
			else
				render json: {error: "Unable to save"}, :status => :unprocessable_entity
				return false
			end

		else
			if city && neighborhood
				@city = City.create(name: city, latitude: lat, longitude: long, neighborhood: neighborhood)
				@pin = UserPin.create(token: device_id, latitude: lat, longitude: long, city_id: @city.id, neighborhood: neighborhood)
				if @pin.save
					head :ok
				else
					render json: {error: "Unable to save"}, :status => :unprocessable_entity
					return false
				end
			else
				render json: {error: "Unable to save"}, :status => :unprocessable_entity
				return false
			end

		end


	end
end
