task :save_countries => :environment do

  City.where(country: "United States").find_each do |city|
    if city.state == nil
      city.save_state
    end
  end

end
