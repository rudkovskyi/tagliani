require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

require_relative 'schema'

require_relative 'models/tag'
require_relative 'models/song'
require_relative 'models/artist'
require_relative 'models/album'