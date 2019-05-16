require_relative "index/object"

module Gossips
  class Search
    class Index
      class << self
        def create_index!(name: Gossips.config.elasticsearch.index, 
                          schema: Gossips.config.schema.default)
          Gossips::Search.client.indices.create index: name, body: schema
        end

        def delete_index!(name: Gossips.config.elasticsearch.index)
          Gossips::Search.client.indices.delete index: name, ignore: 404
        end

        def bulk!(name: Gossips.config.elasticsearch.index,
                  queue: Gossips.config.redis.queue,
                  length: Gossips.config.redis.length)
          indices = Gossips.redis.spop(queue, length)
          data = parse_data(indices, index_name: name)
          return false if data.empty?

          Gossips::Search.client.bulk(body: data)
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
      end
    end
  end
end