require './server'
set :enviroment, :production
configure(:production) {enable :logging}

run Sinatra::Application
