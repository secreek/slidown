require './server'
require 'data_mapper'

set :enviroment, :production
configure(:production) {enable :logging}

# Setup
DataMapper.setup(:default, 'mysql://root:root@localhost/slidown_development')

run Sinatra::Application
