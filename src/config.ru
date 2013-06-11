require './server'
set :enviroment, :production
configure(:production) {enable :logging}

# Setup
DataMapper.setup(:default, 'mysql://root:root@127.0.0.1/slidown_development')

run Sinatra::Application
