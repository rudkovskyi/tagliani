class Tweet < ActiveRecord::Base
  taggable tag_kls: "Hashtag"
end