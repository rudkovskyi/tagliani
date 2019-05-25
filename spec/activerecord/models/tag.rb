class Tag < ActiveRecord::Base
  include Tagliani::Concerns::Search
end