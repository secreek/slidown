require 'sinatra'
require 'base64'
require 'json'
require 'net/http'
require 'uri'
require 'uuid'
require 'rqrcode'

# Require slide generate related stuff
%w{meta entity parser builder generator}.each do |file|
  require "#{File.dirname(__FILE__)}/../#{file}.rb"
end

# Create new slide
get '/new' do
  @user = params[:user]
  @topic = params[:topic]

  erb :upload
end

post '/new' do
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

  meta = MetaParser.new(@file_content)
  parser = MarkdownParser.new(@file_content)
  builder = Builder.new parser.parse
  generator = Generator.new base_path, @user, @topic, 'guide', meta
  generator.generate builder.build_tree

  redirect "/#{@user}/#{@topic}"
end

# Fav some slide
post '/fav' do
end

# Get All slides
get '/:user/_all' do
  @user = params[:user]
  @path = File.expand_path(".") + "/file_repo/#@user"
  unless Dir.exist? @path
    erb :user_not_found
  else
    erb :slide_list
  end
end

# Choosing role
get '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]
  erb :login
end

post '/:user/:topic' do
  @user = params[:user]
  @topic = params[:topic]

  role = params[:role]
  response.set_cookie 'slidown_role', role

  redirect "/#{@user}/#{@topic}/0"
end

# Displaying welcome page
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

# treat page 0 differently
get '/:user/:topic/0' do
  @user = params[:user]
  @topic = params[:topic]
  erb :opening
end

get '/:user/:topic/:page' do
  user = params[:user]
  topic = params[:topic]
  page = params[:page]
  partial = params[:partial] || false

  begin
    File.read(File.join("#{base_path}/#{user}/#{topic}", (partial ? "partial_" : "") + "#{page}.html"))
  rescue Errno::ENOENT
    raise Sinatra::NotFound
  end
end
