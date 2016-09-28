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
    used_city = self.city_name || self.town
    used_neighborhood = self.neighborhood || self.suburb
    self.update_attributes(used_city: used_city, used_neighborhood: used_neighborhood)
  end


  def check_four
    str = '{ "type": "Feature", "properties": { "woe_id": 58792, "name": "México", "name_en": null, "name_adm0": "Costa Rica", "name_adm1": "San Jose", "name_adm2": "San José", "name_lau": "Carmen", "name_local": "San José", "woe_adm0": 23424791, "woe_adm1": 2345088, "woe_adm2": 26808844, "woe_lau": 26808924, "woe_local": 59426, "woe_ver": "7.10.0", "placetype": "Suburb", "gn_id": 3622862, "gn_name": "México", "gn_fcode": "PPLX", "gn_adm0_cc": "CR", "gn_namadm1": "08", "gn_local": 3621849, "gn_nam_loc": "San Jose, San José, San José, CR", "woe_funk": null, "quad_count": 12, "photo_sum": 132, "photo_max": 41, "localhoods": 27, "local_sum": 19186, "local_max": 6857 }, "geometry": { "type": "Polygon", "coordinates": [ [ [ -84.070422433276178, 9.976736841175153 ], [ -84.06869356526974, 9.975812741973272 ], [ -84.068250162259432, 9.975448850526874 ], [ -84.068227951666699, 9.975455588036624 ], [ -84.066587133670112, 9.975953324734093 ], [ -84.064636230449992, 9.976145471930025 ], [ -84.062685327229744, 9.975953324734093 ], [ -84.062633000440542, 9.975937451576016 ], [ -84.061889648425051, 9.974427957219831 ], [ -84.061889648414478, 9.968850608549999 ], [ -84.061889648414478, 9.963440335310096 ], [ -84.061889648425051, 9.96318231585424 ], [ -84.06516406074644, 9.961187586283486 ], [ -84.065312610893898, 9.960131816815903 ], [ -84.067382790410164, 9.958029972340015 ], [ -84.067382812499943, 9.958029949912344 ], [ -84.069453017164619, 9.955928079903373 ], [ -84.069537909501264, 9.955324751605303 ], [ -84.072875976600073, 9.955324753796262 ], [ -84.075622558599861, 9.955324753940673 ], [ -84.07699584962495, 9.956719036569226 ], [ -84.078369139344659, 9.95532475457874 ], [ -84.079742431649763, 9.953930466615617 ], [ -84.08111572268524, 9.955324753940673 ], [ -84.083862304699949, 9.955324753473576 ], [ -84.087879500655674, 9.955324751605303 ], [ -84.087879583464002, 9.955324701160137 ], [ -84.095001220386507, 9.955324701160137 ], [ -84.095556822067522, 9.956364158794598 ], [ -84.095592026883651, 9.956353479530449 ], [ -84.090588679418147, 9.96651340285382 ], [ -84.088210352776741, 9.967854940826967 ], [ -84.085656128785843, 9.972523026534645 ], [ -84.082192894121818, 9.976039379800099 ], [ -84.081115722649997, 9.976145471930025 ], [ -84.079487517744326, 9.975985107743909 ], [ -84.079483277567931, 9.975984690122957 ], [ -84.078076101923671, 9.976736841175153 ], [ -84.076200170819959, 9.977305898653981 ], [ -84.074249267599924, 9.977498045850169 ], [ -84.072298364379719, 9.977305898653981 ], [ -84.070422433276178, 9.976736841175153 ] ] ] } }'
    geom = RGeo::GeoJSON.decode(str, json_parser: :json)

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
