require 'json'

class Geocoder
  attr_accessor :location_hash

  # Constants
  FILE = File.expand_path('../../lib/data/customers.json', File.dirname(__FILE__)) 
  CENTRE_CORD = [53.3393, -6.2576841]
  FIELDS = ["name", "user_id"]

  # To find nearby locations.
  def find_nearby
    locations = read_locations_from FILE
    locations.select_within_radius 100 
    locations.sort.filter_fields
  end

  # To read locations from given file.
  def read_locations_from file
    data_hash = []
    File.readlines(file).each do |line|
      data_hash << JSON.parse(line)
    end
    self.location_hash = data_hash
    self
  end

  # To select hashes within given distance.
  def select_within_radius km
    self.location_hash = location_hash.select {|h1| distance(h1) <= km }
  end

  # To calculate distance
  def distance hash
    Calculation.new([hash["latitude"], hash["longitude"]], CENTRE_CORD).distance
  end

  # To sort array of hash.
  def sort
    self.location_hash = location_hash.sort_by { |hsh| hsh["user_id"] }
    self
  end

  # To filter hashes.
  def filter_fields
    filtered_locations = location_hash.map {|hs| hs.select {|key, value| FIELDS.include?(key) }}    
    filtered_locations
  end
end

