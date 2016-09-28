class UserPin < ActiveRecord::Base
	belongs_to :city

  scope :has_geocoded, -> { where.not(country: nil) }
  scope :missing_neighborhood, -> { where.not(country: nil).where(used_neighborhood: nil) }
  scope :missing_city, -> { where.not(country: nil).where(used_city: nil) }

  def self.run_geocoder(pin_id)
    pin = self.find(pin_id)
    result = Geocoder.search("#{pin.latitude},#{pin.longitude}").first
    # TODO: rescue error?
    neighborhood = result.data['address']['neighbourhood']
    suburb = result.data['address']['suburb']
    town = result.data['address']['town']
    city_name = result.data['address']['city']
    state = city = result.data['address']['state']
    country = city = result.data['address']['country']
    pin.update_attributes(neighborhood: neighborhood, suburb: suburb, town: town, city_name: city_name, state: state, country: country)
    pin.set_used_fields
  end

  def set_used_fields
    used_city = self.quat_city || self.city_name || self.town
    used_neighborhood = self.quat_neighborhood || self.neighborhood || self.suburb
    self.update_attributes(used_city: used_city, used_neighborhood: used_neighborhood)
  end

  def check_bushwick
    bushwick = Geokit::Polygon.new([
      Geokit::LatLng.new(40.705722,-73.939475),
      Geokit::LatLng.new(40.707837,-73.927223),
      Geokit::LatLng.new(40.709464,-73.921859),
      Geokit::LatLng.new(40.695539,-73.899157),
      Geokit::LatLng.new(40.683173,-73.911946),
      Geokit::LatLng.new(40.689584,-73.927396),
      Geokit::LatLng.new(40.698109,-73.947051)
    ])
    pin = Geokit::LatLng.new(self.latitude, self.longitude)
    bushwick.contains?(pin)
  end

end
