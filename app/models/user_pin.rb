class UserPin < ActiveRecord::Base
	belongs_to :city

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
    used_city = self.city_name || self.town
    used_neighborhood = self.neighborhood || self.suburb
    self.update_attributes(used_city: used_city, used_neighborhood: used_neighborhood)
  end

end
