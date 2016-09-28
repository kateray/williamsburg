task :check_bushwick => :environment do

  UserPin.where(city_name: 'New York City').each do |pin|
    if pin.check_bushwick == true
      pin.update_attributes(override_neighborhood: 'Bushwick')
    end
  end

end
