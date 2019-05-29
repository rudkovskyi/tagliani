class Album < ActiveRecord::Base
  has_many :songs
  belongs_to :artist

  taggable inherit: :artist
end