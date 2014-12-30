class UserPinsController < ApplicationController

	def add
		#TODO authentication
		name = params[:c].downcase
		@city = City.find_or_create_by(name: name)

		@pin = UserPin.new
		@pin.latitude = params[:lt].to_i
		@pin.longitude = params[:lg].to_i
		@pin.city_id = @city.id

		if @pin.save
			render json: {id: @pin.id}
		end
	end

end
