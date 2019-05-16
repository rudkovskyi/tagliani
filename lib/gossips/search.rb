require "elasticsearch"
require "json"

require_relative "search/index"

module Gossips
  class Search
    class << self
      def client
        Elasticsearch::Client.new host: Gossips.config.elasticsearch.url,
                                  log: Gossips.config.elasticsearch.log
      end
    end
  end
end