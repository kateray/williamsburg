task :update_neighborhoods => :environment do

  City.where(country: 'United States').find_each do |city|
    if city.neighborhood == nil
      result = Geocoder.search(city.latitude.to_s + ',' + city.longitude.to_s).first
      city.update_attribute('neighborhood', result.neighborhood || '')
      puts "*"*80
      puts result.neighborhood
    end
  end
  # City.where(country: 'United States').find_each do |city|
  #   city.user_pins.each do |u|
  #     result = Geocoder.search(u.latitude.to_s + ',' + u.longitude.to_s).first
  #     if u.neighborhood != result.neighborhood
  #       puts "*"*80
  #       puts u.neighborhood + ' to ' + result.neighborhood
  #       u.update_attribute('neighborhood', result.neighborhood)
  #     end
  #   end
  # end

end
