class Hashtag < ActiveRecord::Base
  include Tagliani::Concerns::Search
end