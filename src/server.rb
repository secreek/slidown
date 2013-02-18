require 'sinatra'
require 'open-uri'
require 'base64'
require 'json'
require 'net/http'
require 'uri'
require 'rqrcode'
require_relative 'meta'
require_relative 'parser'
require_relative 'builder'
require_relative 'generator'
require 'omniauth'
require 'omniauth-github'
require 'omniauth-openid'
require 'openid/store/filesystem'
require 'omniauth-google-oauth2'
require 'openssl'

module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


base_path = 'file_repo'
slidown_url = 'http://slidown.com'

# Simulate network lag
before do
  sleep 0
end

#User Authentication with Github Gmail and OpenID

use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :github, '87a45513d2fa93e5854b', '60688ec9202a8782c5e32c707520b7ecdff497f5', scope: "user"
    provider :google_oauth2, '369476432445.apps.googleusercontent.com', 'wGNmnLGkqBCWBBkdX59aD2v3', {}
    provider :open_id, store: OpenID::Store::Filesystem.new('/tmp')
  end

  get '/signup' do
    <<-HTML
    <ul>
        <li><a href='/auth/github'>Login with Github</a></li>
        <li><a href='/auth/google_oauth2'>Sign in with Google</a></li>
        <li><a href='/auth/open_id?openid_url=https://openid.stackexchange.com'>Sign in with OpenID_StackExchange</a></li>
        <li><a href='/auth/open_id?openid_url=https://www.google.com/accounts/o8/id'>Sign in with OpenID_Google</a></li>
        <li><a href='/auth/open_id?openid_url=https://me.yahoo.com'>Sign in with OpenID_Yahoo</a></li>
        <li><a href='/auth/open_id?openid_url=http://www.flickr.com/username'>Sign in with OpenID_Flickr</a></li>
        <li><a href='/auth/open_id?openid_url=http://openid.aol.com/username'>Sign in with OpenID_AOL</a></li>
        <li><a href='/auth/open_id?openid_url=https://www.blogspot.com/'>Sign in with OpenID_Blogspot</a></li>
        <li><a href='/auth/open_id?openid_url=http://username.livejournal.com/'>Sign in with OpenID_LiveJournal</a></li>
        <li><a href='/auth/open_id?openid_url=https://username.wordpress.com/'>Sign in with OpenID_Wordpress</a></li>
        <li><a href='/auth/open_id?openid_url=https://pip.verisignlabs.com/'>Sign in with OpenID_VerisignLabs</a></li>
        <li><a href='/auth/open_id?openid_url=https://www.myopenid.com/'>Sign in with OpenID_MyOpenID</a></li>
        <li><a href='/auth/open_id?openid_url=https://myvidoop.com/'>Sign in with OpenID_MyVidoop</a></li>
        <li><a href='/auth/open_id?openid_url=https://claimid.com/username'>Sign in with OpenID_ClaimID</a></li>
        <li><a href='/auth/open_id?openid_url=https://technorati.com/people/technorati/username/'>Sign in with OpenID_Technorati</a></li>
    </ul>
  HTML
  end



  %w(get post).each do |method|
    send(method, "/auth/:provider/callback") do

    #TODO: Add the route or anything you want   
    <<-HTML
        <h1>#{params[:provider]}</h1>
        <pre>#{JSON.pretty_generate(env['omniauth.auth'])}</pre>
        <a href='/logout'>Logout</a>
    HTML
    end
  end

  get '/auth/failure' do
    #TODO: Add the Auth Failure view
    #
    erb "<h1>Authentication Failed:</h1><h3>message:</h3><pre>#{params}</pre><a href='/'>index</a>"
  end

  get '/auth/:provider/deauthorized' do
    #TODO: Add the Deauthorized View
    erb "#{params[:provider]} has deauthorized this app."
  end

  get '/protected' do
    #TODO: Add the NOT Authorized 
    throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
    erb %Q{
      <pre>#{request.env['omniauth.auth'].to_json}</pre><hr>
      <a href='/logout'>Logout</a>
    }
  end

  get '/logout' do
    session[:authenticated] = false
    redirect '/'
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

  meta = MetaParser.new(@file_content)
  parser = MarkdownParser.new(@file_content)
  builder = Builder.new parser.parse
  generator = Generator.new base_path, @user, @topic, 'guide', meta
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

