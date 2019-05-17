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

    attr_reader :client

    def initialize(query = {})
      @index = Gossips.config.elasticsearch.index
      @query = query
      @client = self.class.client
    end

    def response
      @client.search(index: @index, body: @query)
    end
  end
end