class UserPin < ActiveRecord::Base
	belongs_to :city

  def save_country
    result = Geocoder.search(self.latitude.to_s + ',' + self.longitude.to_s).first
    self.update_attribute('country', result.country)
  end

end
