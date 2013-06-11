# Wraps stuff for OAuth Providers
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
