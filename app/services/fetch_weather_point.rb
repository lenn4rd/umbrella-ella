class FetchWeatherPoint
  attr_accessor :lat, :lon
  
  API_ENDPOINT = 'http://api.openweathermap.org/data/2.5/weather'
  
  def initialize(lat, lon)
    self.lat = lat.to_f
    self.lon = lon.to_f
  end
  
  def call
    find_in_cache || find_with_api
  end
  
  private
  
  def client
    @client ||= Hurley::Client.new(API_ENDPOINT)
  end
  
  def find_in_cache
    WeatherPoint.find_by(lat: lat, lon: lon)
  end
  
  def find_with_api
    response = query_api
    
    if response.success?
      body = JSON.parse(response.body)
      attributes = {}
      
      attributes.tap do |a|
        a[:lat]         = body['coord']['lat']
        a[:lon]         = body['coord']['lon']
        a[:description] = body['weather'][0]['description']
        a[:temperature] = body['main']['temp']
        a[:wind_speed]  = body['wind']['speed']
      end
      
      point = WeatherPoint.create attributes
    end
  end
  
  def query_api
    client.get('') do |request|
      request.query['lat'] = lat
      request.query['lon'] = lon
    end
  end
end