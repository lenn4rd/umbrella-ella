require 'rails_helper'

feature 'OpenWeatherMap Request' do
  it 'queries the API for weather data' do
    uri = URI.parse('http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139')
    response = JSON.parse(Net::HTTP.get(uri))
    
    expect(response['name']).to eq('Koh Tao')
  end
end