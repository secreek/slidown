require 'data_mapper'

# The User model
class User
  include DataMapper::Resource

  property :id,         Serial
  property :email,      String
  property :password,   String
  property :nickname,   String

  # n slides created by myself
  has n, :slides

  # n slides that I've marked as favorites
  has n, :favslides
  has n, :favs, 'Slide', :through => :favslides

  property :created_at, DateTime, :default => Time.now
end

DataMapper.auto_upgrade!
