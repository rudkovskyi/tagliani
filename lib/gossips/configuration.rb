require_relative "configuration/elasticsearch"
require_relative "configuration/redis"
require_relative "configuration/schema"
require_relative "configuration/tag"

module Gossips
  class Configuration
    attr_reader :elasticsearch, :redis, :schema, :tag
    
    def initialize
      @elasticsearch = Elasticsearch.new
      @redis = Redis.new
      @schema = Schema.new
      @tag = Tag.new
    end
  end
end