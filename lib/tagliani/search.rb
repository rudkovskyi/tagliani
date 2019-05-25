require "elasticsearch"
require "json"

require_relative "search/index"

module Tagliani
  class Search
    class << self
      def client
        Elasticsearch::Client.new host: Tagliani.config.elasticsearch.url,
                                  log: Tagliani.config.elasticsearch.log
      end
    end

    attr_reader :client

    def initialize(query = {})
      @index = Tagliani.config.elasticsearch.index
      @client = self.class.client
      @where_clause = query.delete(:where)
      @query = query

      build_where(@where_clause) if @where_clause
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

    private

    def build_where(args)
      @query[:query] ||= {}
      @query[:query][:bool] ||= {}
      @query[:query][:bool][:must] ||= []
      
      @query[:query][:bool][:must] << [
        query_string: {
          query: build_query_string(args)
        }
      ]
    end

    def build_query_string(args)
      query = args.to_h.map do |key, val|
        "(#{val.map { |object| "#{key}:#{object}" }.join(' OR ')})"
      end.join(' AND ')
    end
  end
end