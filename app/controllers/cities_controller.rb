class CitiesController < ApplicationController
  http_basic_authenticate_with name: ENV['RAILS_ADMIN_USERNAME'], password: ENV['RAILS_ADMIN_PASSWORD'], only: :index

  def home
    @nyc_data = []
    pins = UserPin.all.group_by{|p| [p.latitude, p.longitude]}
    pins.each do |pin|
      @nyc_data << {lat: pin[0][0], lng: pin[0][1], count: pin[1].count}
    end
    @nyc_data = @nyc_data.to_json
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
