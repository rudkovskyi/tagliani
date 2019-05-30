class Producer < ActiveRecord::Base
  has_many :albums
  taggable
end