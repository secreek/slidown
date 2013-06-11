require 'data_mapper'
require 'time'

# User Fav Slide model
class FavSlide
  include DataMapper::Resource

  property :created_at, DateTime, :default => Time.now

  belongs_to :user,   :key => true
  belongs_to :slide,  :key => true
end

DataMapper.auto_upgrade!
