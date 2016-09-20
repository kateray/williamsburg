task :save_countries => :environment do

  City.all.find_each do |city|
    if city.country == nil
      city.save_country
    end
  end

end
