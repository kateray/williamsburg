class UserPinsController < ApplicationController

	def add
		#TODO authentication
		name = params[:c].downcase
		@city = City.find_or_create_by(name: name)

		@pin = UserPin.new
		@pin.latitude = params[:lt].to_f
		@pin.longitude = params[:lg].to_f
		@pin.neighborhood = params[:n].downcase
		@pin.city_id = @city.id

		if @pin.save
			@city.calculate_location
			render json: {id: @pin.id}
		end
	end

end
