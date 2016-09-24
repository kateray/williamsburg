class City < ActiveRecord::Base
	has_one :admin_pin
	has_many :user_pins

	geocoded_by :address

  def save_country
    result = Geocoder.search(self.latitude.to_s + ',' + self.longitude.to_s).first
    self.update_attribute('country', result.country)
  end

  def save_state
    result = Geocoder.search(self.latitude.to_s + ',' + self.longitude.to_s).first
    self.update_attribute('state', result.state)
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
    self.mode(self.user_pins.where.not(neighborhood: nil).pluck(:neighborhood))
  end

  def get_pin_nabes
    self.user_pins.pluck(:neighborhood)
  end

	def create_or_return_pin(device_id, lat, long, neighborhood)
		pin = self.user_pins.find_by_token(device_id) || UserPin.create(token: device_id, city_id: self.id)
		pin.latitude = lat
		pin.longitude = long
		puts '*'*80
		puts neighborhood
		if neighborhood
			pin.neighborhood = neighborhood
		end
		puts pin.to_json
		return pin
	end

	def average_lat
		UserPin.where(city_id: self.id).average(:latitude)
	end

	def average_long
		UserPin.where(city_id: self.id).average(:longitude)
	end

  def calculate_without_admin
    new_lat = nil
    new_long = nil
    new_neighborhood = nil

    new_lat = self.average_lat
    new_long = self.average_long

    if new_lat && new_long
      if (new_lat != self.latitude) || (new_long != self.longitude)
        self.latitude = new_lat
        self.longitude = new_long
        puts "Saving #{self.name}"
        self.save
      end
    end
  end

	def calculate_location
		new_lat = nil
		new_long = nil
		new_neighborhood = nil

		if self.admin_pin
			new_neighborhood = self.admin_pin.neighborhood
			#City has both an admin pin and some user pins, so give a weighted average
			if self.user_pins.any?
				new_lat = (self.average_lat + self.admin_pin.latitude) / 2
				new_long = (self.average_long + self.admin_pin.longitude) / 2
			#City only has an admin pin, so just use that
			else
				new_lat = self.admin_pin.latitude
				new_long = self.admin_pin.longitude
			end
		#City only has user pins, so give an average
		elsif self.user_pins.any?
			new_neighborhood = self.user_pins.first.neighborhood
			new_lat = self.average_lat
			new_long = self.average_long
		end

		if new_lat && new_long
			if (new_lat != self.latitude) || (new_long != self.longitude)
				self.latitude = new_lat
				self.longitude = new_long
				self.neighborhood = new_neighborhood
				puts "Saving #{self.name}"
				self.save
			end
		end
	end

	def as_json(options={})
		{ neighborhood: self.neighborhood, latitude: self.latitude, longitude: self.longitude, city: self.name }
	end
end
