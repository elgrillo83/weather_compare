require 'sinatra'
require 'haml'
require 'wunderground'
require 'open-uri'
require 'json'

WUNDERGROUND_API_KEY = '3ba7b015d08f9935'

get '/' do
  @forecast = forecast_open_uri
  haml :index
end

def w_api
  Wunderground.new(WUNDERGROUND_API_KEY)
end

def forecast_open_uri
  open('http://api.wunderground.com/api/3ba7b015d08f9935/geolookup/conditions/q/Germany/Berlin.json') do |f|
    json_string = f.read
    parsed_json = JSON.parse(json_string)
    location = parsed_json['location']['city']
    temp_c = parsed_json['current_observation']['temp_c']
    return "Current temperature in #{location} is: #{temp_c}\n"
  end
end

def forecast_wunderground
  w_api.forecast_for('Germany', 'Berlin')
end
