require './server'
require 'data_mapper'

set :enviroment, :production
configure(:production) {enable :logging}

run Sinatra::Application
