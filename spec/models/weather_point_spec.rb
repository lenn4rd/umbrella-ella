require 'rails_helper'

describe WeatherPoint do
  let(:point) { build(:weather_point) }
  
  it 'has a factory' do
    expect(point).to be_valid
  end
  
  it 'has a latitude' do
    expect(point.lat).to eq(52.1)
  end
  
  it 'has a longitude' do
    expect(point.lon).to eq(9.95)
  end
  
  it 'has a description' do
    expect(point.description).to eq('partly cloudy')
  end
  
  it 'has the temperature' do
    expect(point.temperature).to eq(275.0)
  end
  
  it 'has the wind speed' do
    expect(point.wind_speed).to eq(3.0)
  end
  
  describe 'ActiveModel validations' do
    it { expect(point).to validate_presence_of(:lat) }
    
    it { expect(point).to validate_presence_of(:lon) }
  end
  
  describe '.find_by' do
    let(:saved) { build(:weather_point).save }
    let(:found) { WeatherPoint.find_by(lat: 52.1, lon: 9.95) }
    
    it 'finds the weather point by its location' do
      expect(found.id).to eq(saved.id)
    end
  end
  
  describe '#key' do
    it 'prints the key' do
      expect(point.key).to eq('5210000995000')
    end
  end
end
