class CitiesController < ApplicationController
  http_basic_authenticate_with name: ENV['RAILS_ADMIN_USERNAME'], password: ENV['RAILS_ADMIN_PASSWORD'], only: :index

	def home
	end

  def index
    @cities = City.all
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
