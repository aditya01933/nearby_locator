require 'spec_helper'

describe Geocoder do 
  let(:locations) {
      [ 
        {"latitude"=>"53.2451022", "user_id"=>4, "name"=>"Ian Kehoe", "longitude"=>"-6.238335"},
        {"latitude"=>"51.92893", "user_id"=>1, "name": "Alice Cahill", "longitude"=>"-10.27699"} 
      ]
  }
  let(:geocoder) {
    geo = Geocoder.new
    geo.location_hash = locations
    return geo
  }
  let(:file) {File.expand_path('../../lib/data/customers.json', File.dirname(__FILE__)) }

  describe '#find_nearby' do
    it 'should return hash of locations' do
      expect(geocoder.find_nearby.count).to eq 16
    end
  end

  describe '#read_locations_from' do
    it 'should fill up location_hash' do
      geocoder.read_locations_from file
      expect(geocoder.location_hash).not_to be_empty
    end
  end

  describe '#select_within_radius' do
    it 'should select location within given range' do      
      expect(geocoder.select_within_radius(100).count).to be 1
    end
  end

  describe '#sort' do
    it 'should sort location of hash based on user_id' do
      expect(geocoder.sort.location_hash[0]["user_id"]).to be 1
    end
  end

  describe '#filter_fields' do
    it 'should return only selected fields' do      
      expect(geocoder.filter_fields[0]).not_to have_key(:latitude)
      expect(geocoder.filter_fields[0]).not_to have_key(:longitude)      
    end
  end  
  
end