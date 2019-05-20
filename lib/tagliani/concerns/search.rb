module Tagliani
  module Concerns
    module Search
      extend ActiveSupport::Concern

      module ClassMethods
        def search(args = {})
          params = {query: { bool: {} }}
          params[:query][:bool][:must] = [
            query_string: {
              query: build_query_string(args.slice(:where))
            }
          ]

          Tagliani::Search.new(params).serialize(type: 'object')
        end

        def build_query_string(args)
          query = args[:where].to_h.map do |key, val|
            "(#{val.map { |object| "#{key}:#{object}" }.join(' OR ')})"
          end.join(' AND ')
        end
      end
    end
  end
end