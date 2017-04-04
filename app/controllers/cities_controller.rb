class CitiesController < ApplicationController
  http_basic_authenticate_with name: ENV['RAILS_ADMIN_USERNAME'], password: ENV['RAILS_ADMIN_PASSWORD'], only: :index

  def home
    @nyc_data = []
    pins = UserPin.all.group_by{|p| [p.latitude, p.longitude]}
    pins.each do |pin|
      @nyc_data << {lat: pin[0][0], lng: pin[0][1], count: pin[1].count}
    end
    @nyc_data = @nyc_data.to_json
    @start_city = default_cities.sample.to_json
  end

  def index
    @cities = City.all
  end

  def search
    if params[:query].blank?
      render json: default_cities.to_json
    else
      @cities = City.search_by_name(params[:query])
      render json: @cities.select('name, latitude, longitude').map{|c| {name: c.name, lat: c.latitude, lng: c.longitude}}
    end
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

  private

  def default_cities
    City.where(:name => ['San Francisco', 'Chicago', 'Washington DC', 'Los Angeles', 'London', 'Berlin']).select('name, latitude, longitude').map{|c| {name: c.name, lat: c.latitude, lng: c.longitude}}
  end

end
