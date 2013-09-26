require 'sinatra'
require 'haml'
require 'wunderground'

get '/' do
  haml :index
end
