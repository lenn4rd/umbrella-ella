require 'sinatra/base'

class FakeOpenWeatherMap < Sinatra::Base
  get '/data/2.5/weather' do
    json_response 200, 'weather.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end