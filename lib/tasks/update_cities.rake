task :update_cities => :environment do

	City.all.find_each do |city|
		city.calculate_without_admin
	end

end
