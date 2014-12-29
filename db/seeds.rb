# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
City.create(name: 'new-york')
City.create(name: 'berlin')
City.create(name: 'london')
City.create(name: 'melbourne')
City.create(name: 'san-francisco')


AdminPin.create(city_id: 1, neighborhood: 'williamsburg', latitude: 40.7133, longitude: -73.9533)
AdminPin.create(city_id: 2, neighborhood: 'kreuzberg', latitude: 52.4875, longitude: 13.3833)
AdminPin.create(city_id: 3, neighborhood: 'shoreditch', latitude: 51.5260, longitude: 0.0780)
AdminPin.create(city_id: 4, neighborhood: 'fitzroy', latitude: -37.8011, longitude: 144.9789)
AdminPin.create(city_id: 5, neighborhood: 'mission', latitude: 37.7600, longitude: -122.4200)
