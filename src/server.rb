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
    erb open('templates/upload.html.erb').read
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
  uri = URI("http://slidown.com/api/#{@user}/#{@topic}/upload")

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
  redirect "/about/me"
end

get '/:user/:topic/upload' do
  @user = params[:user]
  @topic = params[:topic]

  erb open('templates/upload.html.erb').read
end

# 选择角色
get '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]
  @qrcode_url = "http://slidown.com" + "/" + @user + "/" + @topic
  @qr = RQRCode::QRCode.new(@qrcode_url,:size => 4,:level=> :h)

  erb open('templates/login.html.erb').read
end

post '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]

  role = params[:role]
  response.set_cookie 'slidown_role', role

  redirect "/#{@user}/#{@topic}/1"
end

get '/:user/:topic/:page' do
  user = params[:user]
  topic = params[:topic]
  page = params[:page]
  File.read(File.join("#{base_path}/#{user}/#{topic}", "#{page}.html"))
end



