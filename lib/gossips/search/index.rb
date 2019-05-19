require_relative "index/object"

module Gossips
  class Search
    class Index
      def initialize(name: nil, schema: nil, queue: nil, length: nil)
        @name = name || Gossips.config.elasticsearch.index
        @schema = schema || Gossips.config.schema.default
        @queue = queue || Gossips.config.redis.queue
        @length = length || Gossips.config.redis.length
        @search = Gossips::Search.new
      end

      def create!
        @search.client.indices.create index: @name, body: @schema
      end

      def delete!
        @search.client.indices.delete index: @name, ignore: 404
      end

      def refresh
        @search.client.indices.refresh
      end

      def parse_data(indices, index_name:)
        [indices].flatten.flat_map do |text|
          object = Object.new(text)

          {
            index: {
              _index: index_name,
              _id: object.id,
              _type: "doc",
              data: object.to_h
            }
          }
        end
      end

      def bulk!
        indices = Gossips.redis.spop(@queue, @length)
        data = parse_data(indices, index_name: @name)
        return false if data.empty?

        @search.client.bulk(body: data)
      end

      def add!(schema, async = false)
        object = Object.new(schema)

        if async
          Gossips.redis.sadd(@queue, object.to_json)
        else
          @search.client.index({
            index: @name,
            type: 'doc',
            id: object.id,
            body: object.to_h,
            refresh: true
          })
        end
      end

      class << self
        def create!(name: nil, schema: nil)
          new(name: name, schema: schema).create!
        end

        def delete!(name: nil)
          new(name: name).delete!
        end

        def move!(from:, to:)
          create!(name: to)
          Gossips::Search.client.reindex({
            body: { source: { index: from }, dest: { index: to } }
          })
        end

        def bulk!(name: nil, queue: nil, length: nil)
          new(name: name, queue: queue, length: length).bulk!
        end
      end
    end
  end
end