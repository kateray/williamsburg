class QuattroWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }


  def check_file(file, pins)
    data_hash = JSON.parse(file)
    data_hash.each do |feature|
      pts = []

      begin
        feature['geometry']['coordinates'][0].each do |long, lat|
          pt = Geokit::LatLng.new(lat, long)
          pts << pt
        end
        nabe = Geokit::Polygon.new(pts)
        pins.each do |pin|
          geo_pin = Geokit::LatLng.new(pin.latitude, pin.longitude)
          if nabe.contains?(geo_pin)
            puts 'hooooray!'
            puts feature['properties']['name_local']
            pin.update_attributes(quat_neighborhood: feature['properties']['name'], quat_city: feature['properties']['name_adm2'])
            pin.set_used_fields
          end
        end
      rescue Exception => e
        Airbrake.notify_or_ignore( error_message: "Error reading file", error_class: "Custom::Quattro::ReadingFile", parameters: { exception_message: e.to_json } )
        # puts e
      end

    end
  end

  def perform
    pins = UserPin.where('used_city IS ? OR quat_neighborhood IS ?',nil,nil).group_by(&:country_code)

    pins.each do |country|
      if country[0] == 'us'
        states = country[1].group_by(&:state)
        states.each do |state|
          puts "checking #{state[0]}"
          file_name = "lib/assets/us/#{state[0].downcase.tr(" ", "_")}.geojson"
          if File.exist?(file_name)
            file = File.read(file_name)
            check_file(file, state[1])
          else
            Airbrake.notify_or_ignore( error_message: "Missing File", error_class: "Custom::Quattro::MissingFile", parameters: { file_missing: "No such file #{file_name}" } )
            puts "No such file #{file_name}"
          end
        end
      else
        puts "checking #{country[0]}"
        file_name = "lib/assets/#{country[0].downcase}.geojson"
        if File.exist?(file_name)
          file = File.read(file_name)
          check_file(file, country[1])
        else
          Airbrake.notify_or_ignore( error_message: "Missing File", error_class: "Custom::Quattro::MissingFile", parameters: { file_missing: "No such file #{file_name}" } )
          puts "No such file #{file_name}"
        end
      end
    end

    City.all.each{|c| c.calculate_location}
  end

end
