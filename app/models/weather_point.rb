class WeatherPoint
  include ActiveModel::Model
  include ActiveModel::Validations
  include Redis::Persistence
  
  GPS_PRECISION = 100_000
  
  # Attributes 
  property :lat
  property :lon
  property :description
  property :temperature
  property :wind_speed
  
  
  validates :lat, :lon, presence: true
  
  
  # Queries Redis using the object's key which is composed using the
  # latitude and longitude. This method used keyword argument with required
  # params introduced in Ruby 2.1 to resemble ActiveRecord's <tt>find_by</tt>
  # methods that use hashes for the parameters.
  def self.find_by(lat:, lon:)
    latitude  = (lat * GPS_PRECISION).round
    longitude = (lon * GPS_PRECISION).round
    key       = "#{latitude}#{longitude}"
    find(key)
  end
  
  def initialize(attributes = {})
    super
    self.id ||= key
  end
  
  # Generates the object key using its latitude and longitude. If either of
  # those is <tt>nil</tt>, return an empty string so that
  # <tt>Redis::Persistence</tt> uses its internal counter for the <tt>id</tt>.
  def key
    return "" if lat.nil? || lon.nil?
    
    latitude  = (lat * GPS_PRECISION).round
    longitude = (lon * GPS_PRECISION).round
    
    "%s%s" % [latitude, longitude]
  end
end