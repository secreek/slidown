require 'sinatra'
require 'open-uri'

base_path = 'file_repo'
slidown_url = 'http://slidown.com'

# Sets erb to trim mode
set :erb, :trim => '-'

# Require all routes
Dir[File.dirname(__FILE__) + "/controller/*.rb"].each { |file| require file }
