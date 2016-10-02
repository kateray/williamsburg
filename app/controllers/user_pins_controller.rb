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
    should_geocode = false

    # user is agreeing with current pin. we do not need to geocode
    if @city && @city.latitude == lat && @city.longitude == long
      @pin = @city.user_pins.find_by_token(device_id) || UserPin.create(token: device_id, city_id: @city.id)
      @pin.latitude = lat
      @pin.longitude = long
      @pin.neighborhood = @city.neighborhood
      @pin.city_name = @city.name
      @pin.state = @city.state
      @pin.country_code = @city.country_code
      @pin.country = @city.country

    else
      # if the city doesn't exist we must create it
      unless @city
        @city = City.create(latitude: lat, longitude: long)
      end
      @pin = @city.user_pins.find_by_token(device_id) || UserPin.create(token: device_id, city_id: @city.id)
      @pin.latitude = lat
      @pin.longitude = long
      should_geocode = true
    end

		#now we attempt to save it
		if @pin && @pin.save
			if should_geocode
        GeocodeWorker.perform_async(@pin.id)
			else
        # necessary for saving the agreement pins
        @pin.set_used_fields
      end
			head :ok
		else
      #TODO: better error handling
			render json: {error: "Unable to save"}, :status => :unprocessable_entity
			return false
		end

	end
end
