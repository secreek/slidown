require 'sinatra'

# Simple & Elegant page for slidown
get '/' do
  "Welcome to Slidown!"
end

not_found do
  erb :'404'
end

error do
  erb :'500'
end
