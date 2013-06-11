require 'data_mapper'

# The Slide Show model
class Slide
  include DataMapper::Resource

  property :id,         Serial
  property :topic,       String

  # Owned by a single user
  belongs_to :user

  # But, maybe favorited my many users
  has n, :favslides
  has n, :users, :through => :favslides

  property :created_at, DateTime, :default => Time.now
end
