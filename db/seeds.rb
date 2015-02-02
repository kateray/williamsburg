# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
City.create(name: 'New York')
City.create(name: 'Berlin')
City.create(name: 'London')
City.create(name: 'Melbourne')
City.create(name: 'San Francisco')
City.create(name: 'San Diego')
City.create(name: 'Boston')
City.create(name: 'Chicago')
City.create(name: 'Los Angeles')
City.create(name: 'Madrid')
City.create(name: 'Saint Louis')
City.create(name: 'Washington DC')


AdminPin.create(city_id: 1, neighborhood: 'Williamsburg', latitude: 40.7133, longitude: -73.9533)
AdminPin.create(city_id: 2, neighborhood: 'Kreuzberg', latitude: 52.4875, longitude: 13.3833)
AdminPin.create(city_id: 3, neighborhood: 'Shoreditch', latitude: 51.5260, longitude: 0.0780)
AdminPin.create(city_id: 4, neighborhood: 'Fitzroy', latitude: -37.8011, longitude: 144.9789)
AdminPin.create(city_id: 5, neighborhood: 'Mission', latitude: 37.7600, longitude: -122.4200)
AdminPin.create(city_id: 6, neighborhood: 'North Park', latitude: 32.7408, longitude: -117.1297)
AdminPin.create(city_id: 7, neighborhood: 'Somerville', latitude: 42.3875, longitude: -71.1000)
AdminPin.create(city_id: 8, neighborhood: 'Wicker Park', latitude: 41.9075, longitude: -87.6769)
AdminPin.create(city_id: 9, neighborhood: 'Silver Lake', latitude: 34.0944, longitude: -118.2675)
AdminPin.create(city_id: 10, neighborhood: 'Malasaña', latitude: 40.4253, longitude: 3.7083)
AdminPin.create(city_id: 11, neighborhood: 'The Grove', latitude: 38.6270, longitude: -90.2569)
AdminPin.create(city_id: 12, neighborhood: 'U Street', latitude: 38.9170, longitude: -77.0296)
