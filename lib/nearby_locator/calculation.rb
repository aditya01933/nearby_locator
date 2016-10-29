class Calculation
  attr_reader :from, :to, :lat1_rad, :lat2_rad, :lon1_rad, :lon2_rad

  RADIUS = 6371 # Earth radius in kilometers
  RADIUS_PER_DEG = Math::PI/180  # PI / 180

  def initialize(from, to)
    @from = from
    @to = to
  end

  def distance     
    dlat_rad, dlon_rad = delta_radians

    a = Math.sin((dlat_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((dlon_rad) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
    RADIUS * c # Delta in meters
  end
  private
    
    # Delta, converted to rad
    def delta_radians
      @lat1_rad, @lon1_rad = from.map {|i| i.to_f * RADIUS_PER_DEG }
      @lat2_rad, @lon2_rad = to.map {|i| i.to_f * RADIUS_PER_DEG }
      [ lat2_rad - lat1_rad, lon2_rad - lon1_rad ]
    end


end