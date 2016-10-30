require_relative "dependencies"

begin
  puts Geocoder.new.find_nearby
rescue Exception => e
  puts e.message
end


