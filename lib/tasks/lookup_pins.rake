task :lookup_pins => :environment do

  UserPin.pluck(:id).each do |pin_id|
    GeocodeWorker.perform_async(pin_id)
  end

end
