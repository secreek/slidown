require 'sinatra'

get '/:user' do
  @user = params[:user]
  @path = File.expand_path(".") + "/file_repo/#{@user}"
  unless Dir.exist?(@path)
    erb :user_not_found
  else
    erb :user
  end
end

get '/register' do
end

post '/register' do
end

get '/login' do
end

post '/login' do
end

post '/logout' do
end
