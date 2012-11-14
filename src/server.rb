require 'sinatra'
require 'open-uri'
require 'base64'
require 'json'
require 'net/http'
require 'uri'
require 'rqrcode'
require_relative 'parser'
require_relative 'builder'
require_relative 'generator'

base_path = 'file_repo'
slidown_url = 'http://slidown.com'

# Simulate network lag
before do
  sleep 0
end

# upload the file
post '/:user/:topic/upload' do
  @user = params[:user]
  @topic = params[:topic]

  unless params[:file] &&
       (tmpfile = params[:file][:tempfile]) &&
       (name = params[:file][:filename])
    @error = 'No file selected'
	erb :upload
  end
  @file_content = ''
  while blk = tmpfile.read(65536)
    # here you would write it to its final location
    @file_content << blk
  end

  parser = MarkdownParser.new(@file_content)
  builder = Builder.new parser.parse
  generator = Generator.new base_path, @user, @topic, 'guide'
  generator.generate builder.build_tree

  redirect "/#{@user}/#{@topic}"
end

post '/api/github_hooks' do
  push = JSON.parse(params[:payload])
  @user = push['repository']['owner']['name']
  @topic = push['repository']['name']
  @path = "https://api.github.com/repos/#{@user}/#{@topic}/contents/README.md"

  # Full control
  uri = URI("http://slidown.com/api/#{@user}/#{@topic}/upload") # FIXME - Using Constants

  Net::HTTP.start(uri.host, uri.port) do |http|
    request = Net::HTTP::Post.new uri.request_uri
    request.set_form_data({"github_path" => @path})

    response = http.request request # Net::HTTPResponse object
  end
end

# try to provide an api for file upload
post '/api/:user/:topic/upload' do
  @user = params[:user]
  @topic = params[:topic]
  @path = params[:github_path]

  data = JSON.load(open(@path).read)
  @file_content = Base64.decode64(data['content'])

  parser = MarkdownParser.new(@file_content)
  builder = Builder.new parser.parse
  generator = Generator.new base_path, @user, @topic, 'guide'
  generator.generate builder.build_tree

  'Success!'
end

# The default homepage was redirect to /about/me
get '/' do
  redirect "/me/about"
end

get '/:user/:topic/upload' do
  @user = params[:user]
  @topic = params[:topic]

  erb :upload
end

# 对于结尾增加 “/” 的请求，重定向到 "/#{@user}/#{@topic}
get '/:user/:topic/' do

  redirect "/#{@user}/#{@topic}"

end

# 选择角色
get '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]
  erb :login
end

get '/:user/:topic/welcome' do
  @user = params[:user]
  @topic = params[:topic]
  @qrcode_url = slidown_url + "/" + @user + "/" + @topic # FIXME - Using Constants

  # QRCode versions
  #http://www.qrcode.com/en/vertable1.html
  #Version 6 Level L Support 1088bits
  #
  #TODO:Use the shorten url  to fix this problem 
  begin
    @qr = RQRCode::QRCode.new(@qrcode_url,:size => 6,:level=> :l)
    erb :welcome
  rescue RQRCode::QRCodeRunTimeError
    "Your url is too long"
  end

  

end

post '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]

  role = params[:role]
  response.set_cookie 'slidown_role', role

  redirect "/#{@user}/#{@topic}/0"
end

get '/:user/:topic/0' do
  @user = params[:user]
  @topic = params[:topic]
  erb :opening
end

get '/:user/:topic/:page' do
  user = params[:user]
  topic = params[:topic]
  page = params[:page]
  
  begin
    File.read(File.join("#{base_path}/#{user}/#{topic}", "#{page}.html"))
  rescue Errno::ENOENT
    raise Sinatra::NotFound
  end


end

not_found do

  '404 Not Found'
  # 404 页面完成后启用如下代码
  #erb :404
end

