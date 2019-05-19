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

    def serialize(type:)
      model_kls = "#{type}_kls"
      model_id = "#{type}_id"

      models = {}

      response['hits']['hits'].each do |entry|
        entry_source = entry['_source']
        class_name = entry_source[model_kls]
        models[class_name] ||= []
        models[class_name] << entry_source[model_id]
      end

      models.flat_map do |model, ids|
        model.constantize.where(id: ids)
      end
    end
  end
end