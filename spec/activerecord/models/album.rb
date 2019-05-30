class Album < ActiveRecord::Base
  has_many :songs
  belongs_to :artist
  belongs_to :producer

  taggable inherit: %i[artist producer]
end