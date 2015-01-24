class CitiesController < ApplicationController

	def home
	end

	def get_williamsburg
		lat = params[:lat].to_f
		long = params[:long].to_f

		@city = City.near([lat, long], 50).first

		if @city
			render json: @city.as_json
		else
			#alert me
		end
	end
end
