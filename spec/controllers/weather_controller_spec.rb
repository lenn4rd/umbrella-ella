require 'rails_helper'

describe WeatherController do
  let(:params) { { lat: '52.1', lon: '9.95', format: :json } }
  
  describe "GET #index" do
    let(:point) { build(:weather_point) }
    
    it "assigns weather data as @point" do
      skip("FakeRedis doesn't store any data")
      get :index, params
      expect(assigns(:point)).to eq(point)
    end
  end
  
  describe 'GET #intro' do
    it 'generates random parameters' do
      get :intro
      expect(assigns(:random)).to be_instance_of(Hash)
    end
  end
end
