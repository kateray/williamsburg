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
		should_calculate_location = false

		# we are agreeing
		if @city && @city.latitude == lat && @city.longitude == long
			@pin = @city.create_or_return_pin(device_id, lat, long, @city.neighborhood)
		else
			#otherwise we must geocode
			result = Geocoder.search(lat.to_s + ',' + long.to_s).first
			#the city exists
			puts '*'*80
			if result.neighborhood.blank?
				puts 'indeed it is blank'
				Airbrake.notify_or_ignore( error_message: "Didn't save neighborhood", error_class: "Custom::GeoCoding::NoNeighborhood", parameters: { geocoded_result: result.to_json } )
			end
			if @city
				@pin = @city.create_or_return_pin(device_id, lat, long, result.neighborhood)
				should_calculate_location = true
			else
				@city = City.create(name: result.city, latitude: lat, longitude: long, neighborhood: result.neighborhood)
				@pin = @city.create_or_return_pin(device_id, lat, long, result.neighborhood)
			end
		end

		#now we attempt to save it
		if @pin && @pin.save
			if should_calculate_location
				@city.calculate_location
			end
			head :ok
		else
			render json: {error: "Unable to save"}, :status => :unprocessable_entity
			return false
		end

	end
end
