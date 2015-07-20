class WeatherController < ApplicationController
  def intro
    lat = Random.rand(90)
    lon = Random.rand(180)
    
    @random = { lat: lat, lon: lon }  
  end
  
  def index
    @point = FetchWeatherPoint.new(params[:lat], params[:lon]).call

    respond_to do |format|
      format.json
    end
  end
end
