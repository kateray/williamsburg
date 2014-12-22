class UserPinsController < ApplicationController

	def add
		#TODO authentication
		#TODO what if there is no city?
		@pin = UserPin.new
		@pin.latitude = params[:lat].to_i
		@pin.longitude = params[:long].to_i
		@pin.city_id = params[:w].to_i

		if @pin.save
			render json: {id: @pin.id}
		end
	end

end
