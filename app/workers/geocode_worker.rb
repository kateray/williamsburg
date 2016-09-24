class GeocodeWorker
  include Sidekiq::Worker

  sidekiq_options throttle: { threshold: 1, period: 1.minute }

  def perform(pin_id)
    UserPin.calculate_location(pin_id)
  end

end
