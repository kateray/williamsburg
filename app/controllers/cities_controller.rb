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
      render :text => "404 Not found", :status => 404
		end
	end

	def get_all
		render json: City.all
	end
end
