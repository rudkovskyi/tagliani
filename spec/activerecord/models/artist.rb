class Artist < ActiveRecord::Base
  has_many :albums
  taggable async: true
end