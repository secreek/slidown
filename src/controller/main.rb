require 'sinatra'
require 'sinatra/contrib'

get '/' do
  user = session[:login] || cookies[:saved_login]
  if user
    session[:login] = user # update login user
    redirect "/#{user}"
  else
    erb :index
  end
end

not_found do
  erb :'404'
end

error do
  erb :'500'
end
