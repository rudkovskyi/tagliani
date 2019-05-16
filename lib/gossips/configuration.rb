require_relative "configuration/elasticsearch"
require_relative "configuration/redis"
require_relative "configuration/schema"

module Gossips
  class Configuration
    attr_reader :elasticsearch, :redis, :schema
    
    def initialize
      @elasticsearch = Elasticsearch.new
      @redis = Redis.new
      @schema = Schema.new
    end
  end
end
