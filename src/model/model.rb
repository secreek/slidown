require 'data_mapper'
require 'digest/md5'

# Setup
DataMapper.setup(:default, 'mysql://root:root@localhost/slidown_development')

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
  has n, :favorite_slides, "FavSlide"
  has n, :favs, self,
    :through => :favorite_slides,
    :via     => :user

  property :created_at, DateTime, :default => Time.now

  def self.create email, origin_pwd, nickname
    user = User.new(:email => email,
      :password => Digest::MD5.hexdigest(origin_pwd),
      :nickname => nickname)
    user.save
    user
  end

  def self.authenticate? email, plain_pwd
    !!User.first(:email => email, :password => Digest::MD5.hexdigest(origin_pwd))
  end

  def self.get_by_nickname nickname
    User.first(:nickname => nickname)
  end

  def self.get_by_email email
    User.first(:email => email)
  end
end

# The Slide Show model
class Slide
  include DataMapper::Resource

  property :id,         Serial
  property :topic,       String

  # Owned by a single user
  belongs_to :user

  # But, maybe favorited my many users
  has n, :favorite_slides, "FavSlide"
  has n, :stargazers, self,
    :through => :favorite_slides,
    :via     => :slide

  property :created_at, DateTime, :default => Time.now
end

# User Fav Slide model
class FavSlide
  include DataMapper::Resource

  property :created_at, DateTime, :default => Time.now

  belongs_to :user,   :key => true
  belongs_to :slide,  :key => true
end

DataMapper.finalize
DataMapper.auto_upgrade!
