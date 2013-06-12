require 'sinatra'
require_relative '../model/model'

get '/register' do
  erb :register
end

post '/register' do
end

get '/login' do
end

post '/login' do
end

post '/logout' do
end

get '/:user' do
  @user = User.get_by_nickname params[:user]
  if !!@user
    @slides = @user.slides
    erb :user
  else
    erb :user_not_found
  end
end
