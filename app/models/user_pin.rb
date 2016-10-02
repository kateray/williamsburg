class UserPin < ActiveRecord::Base
	belongs_to :city

  scope :missing_neighborhood, -> { where(used_neighborhood: nil) }
  scope :missing_city, -> { where(used_city: nil) }

  def self.run_geocoder(pin_id)
    pin = self.find(pin_id)
    result = Geocoder.search("#{pin.latitude},#{pin.longitude}").first
    # TODO: rescue error?
    neighborhood = result.data['address']['neighbourhood']
    suburb = result.data['address']['suburb']
    town = result.data['address']['town']
    city_name = result.data['address']['city']
    state = result.data['address']['state']
    country = result.data['address']['country']
    country_code = result.data['address']['country_code']
    pin.update_attributes(neighborhood: neighborhood, suburb: suburb, town: town, city_name: city_name, state: state, country: country, country_code: country_code)
    if country_code == 'us'
      if pin.check_bushwick == true
        pin.update_attributes(override_neighborhood: 'Bushwick')
      end
    end
    pin.set_used_fields
  end

  def set_used_fields
    used_city = self.quat_city || self.city_name || self.town
    used_neighborhood = self.override_neighborhood || self.quat_neighborhood || self.neighborhood || self.suburb
    self.update_attributes(used_city: used_city, used_neighborhood: used_neighborhood)
  end

  def check_bushwick
    bushwick = Geokit::Polygon.new([
      Geokit::LatLng.new(40.705218, -73.939403),
      Geokit::LatLng.new(40.707886, -73.927301),
      Geokit::LatLng.new(40.709122, -73.921465),
      Geokit::LatLng.new(40.703038, -73.911122),
      Geokit::LatLng.new(40.701932, -73.912195),
      Geokit::LatLng.new(40.700631, -73.909920),
      Geokit::LatLng.new(40.699492, -73.911079),
      Geokit::LatLng.new(40.695295, -73.903526),
      Geokit::LatLng.new(40.693700, -73.905114),
      Geokit::LatLng.new(40.691618, -73.901423),
      Geokit::LatLng.new(40.686607, -73.904942),
      Geokit::LatLng.new(40.683124, -73.905801),
      Geokit::LatLng.new(40.682799, -73.904427),
      Geokit::LatLng.new(40.681953, -73.902968),
      Geokit::LatLng.new(40.679154, -73.905200),
      Geokit::LatLng.new(40.683938, -73.912452),
      Geokit::LatLng.new(40.696922, -73.935498),
      Geokit::LatLng.new(40.700501, -73.941635),
      Geokit::LatLng.new(40.705218, -73.939403)
    ])
    pin = Geokit::LatLng.new(self.latitude, self.longitude)
    bushwick.contains?(pin)
  end

end
