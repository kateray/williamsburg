task :check_bushwick => :environment do

  UserPin.where(city_name: 'New York City').where(used_neighborhood: nil).each do |pin|
    if pin.check_bushwick == true
      pin.update_attributes(used_neighborhood: 'Bushwick')
    end
  end

end
