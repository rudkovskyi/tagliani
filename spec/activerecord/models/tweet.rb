class Tweet < ActiveRecord::Base
  taggable tag_kls: "Hashtag"
  has_many :retweets
end