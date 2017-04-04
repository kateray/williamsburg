class City < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_name, :against => :name, :using => {:tsearch => {:prefix => true}}

	has_one :admin_pin
	has_many :user_pins

	geocoded_by :address

	def average_lat
		UserPin.where(city_id: self.id).average(:latitude)
	end

	def average_long
		UserPin.where(city_id: self.id).average(:longitude)
	end

  def mode(x)
    sorted = x.sort
    a = Array.new
    b = Array.new
    sorted.each do |x|
      if a.index(x)==nil
        a << x # Add to list of values
        b << 1 # Add to list of frequencies
      else
        b[a.index(x)] += 1 # Increment existing counter
      end
    end
    maxval = b.max           # Find highest count
    where = b.index(maxval)  # Find index of highest count
    a[where]                 # Find corresponding data value
  end

  def get_pin_mode
    names = self.user_pins.where.not(used_neighborhood: nil).pluck(:used_neighborhood)
    unless names.empty?
      self.mode(names)
    end
  end

  def get_pin_count
    self.user_pins.where(used_neighborhood: self.get_pin_mode).count
  end

  def get_center(place)
    search_array = []
    self.user_pins.where(used_neighborhood: place).each do |p|
      search_array.push([p.latitude, p.longitude])
    end
    Geocoder::Calculations.geographic_center(search_array)
  end

	def calculate_location
    neighborhood = self.get_pin_mode
    center = self.get_center(neighborhood)
    state = self.user_pins.where(used_neighborhood: neighborhood).first.state
    country_code = self.user_pins.where(used_neighborhood: neighborhood).first.country_code
    country = self.user_pins.where(used_neighborhood: neighborhood).first.country
    self.update_attributes(neighborhood: neighborhood, latitude: center[0], longitude: center[1], state: state, country: country, country_code: country_code)
	end

	def as_json(options={})
		{ neighborhood: self.neighborhood, latitude: self.latitude, longitude: self.longitude, city: self.name }
	end
end
