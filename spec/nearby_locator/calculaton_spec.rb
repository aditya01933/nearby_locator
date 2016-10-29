require 'spec_helper'

describe Calculation do 
# All distance calculatons are reference to Google Map.
  context 'when small distance ~ 10km ' do
    # Distance calculaton between Aviva Stadium and St Patrick's Cathedral, Dublin
    it 'should give correct distance between 2 coordinates' do
      distance = Calculation.new([53.335233, -6.227457], [53.339552, -6.271291]).distance
      expect(distance.round(2)).to eq 2.95
    end
  end
  # Negligible small Error of 
  context 'when medium distance ~ 100km ' do
    it 'should give correct distance between 2 coordinates' do
      distance = Calculation.new([53.335233, -6.227457], [54.339552, -6.271291]).distance
      expect(distance.round(2)).to eq 111.71
    end
  end 

  # Error of ~ 1km 
  context 'when large distance ~ 1000km ' do
    it 'should give correct distance between 2 coordinates' do
      distance = Calculation.new([53.335233, -6.227457], [62.339552, -6.271291]).distance
      expect(distance.round(2)).to eq 1001.24
    end
  end


end