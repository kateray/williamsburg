class City < ActiveRecord::Base
	has_one :admin_pin
	has_many :user_pins

	geocoded_by :address

	def average_lat
		UserPin.where(city_id: self.id).average(:latitude)
	end

	def average_long
		UserPin.where(city_id: self.id).average(:longitude)
	end

	def calculate_location
		new_lat = nil
		new_long = nil
		new_neighborhood = nil

		new_neighborhood = self.user_pins.first.neighborhood
		new_lat = self.average_lat
		new_long = self.average_long

		if (new_lat != self.latitude) || (new_long != self.longitude)
			self.latitude = new_lat
			self.longitude = new_long
			self.neighborhood = new_neighborhood
			puts "Saving #{self.name}"
			self.save
		end
	end

	def as_json(options={})
		{ neighborhood: self.neighborhood, latitude: self.latitude, longitude: self.longitude, city: self.name }
	end
end
