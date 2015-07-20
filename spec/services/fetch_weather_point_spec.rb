require 'rails_helper'

describe FetchWeatherPoint do
  let(:lat)     { '52.1' }
  let(:lon)     { '9.95' }
  let(:service) { FetchWeatherPoint.new(lat, lon) }
  
  describe '.initialize' do
    it 'assigns the attributes' do
      expect(service.lat).to eq(52.1)
      expect(service.lon).to eq(9.95)
    end
  end
  
  describe '#call' do
    context 'weather data is cached' do
      it 'returns the object' do
        point  = build(:weather_point).save
        result = service.call
        
        expect(result).to be
        expect(result.key).to eq('5210000995000')
      end
    end
    
    context 'weather data is not cached' do
      let(:point) { WeatherPoint.find_by(lat: lat, lon: lon) }
      
      it 'queries the API' do
        result = service.call
        
        expect(result).to be
        expect(result.key).to eq('10100009984000')
        expect(result.description).to eq('light rain')
      end
      
      it 'caches the object' do
        skip("FakeRedis doesn't store any data")
        expect(point).to be
        expect(point.key).to eq('10100009984000')
      end
    end
  end
end