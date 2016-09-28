task :check_foursquare => :environment do

  ['lib/assets/neighborhoods-1.geojson', 'lib/assets/neighborhoods-2.geojson', 'lib/assets/neighborhoods-3.geojson', 'lib/assets/neighborhoods-4.geojson', 'lib/assets/neighborhoods-5.geojson'].each do |f|

    puts "reading file #{f}"
    
    file = File.read(f)
    data_hash = JSON.parse(file)

    data_hash.each_with_index do |feature, i|
      pts = []

      puts "reviewing #{i} #{feature['properties']['name']}"
      begin
        feature['geometry']['coordinates'][0].each do |long, lat|
          pt = Geokit::LatLng.new(lat, long)
          pts << pt
        end
        nabe = Geokit::Polygon.new(pts)

        UserPin.where.not(country: nil).where(used_neighborhood: nil).each do |pin|
          geo_pin = Geokit::LatLng.new(pin.latitude, pin.longitude)
          if nabe.contains?(geo_pin)
            puts 'hooooray!'
            puts feature['properties']['name']
            pin.update_attributes(quat_neighborhood: feature['properties']['name'])
          end
        end
      rescue Exception => e
        puts e
      end
    end

  end


end
