class CitiesController < ApplicationController

	def home
	end
	
	def get_williamsburg
		name = params[:name].downcase
		@city = City.find_by_name(name)

		if @city
			render json: @city.as_json
		else
			#alert me
		end
	end
end
