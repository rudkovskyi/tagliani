module Gossips
  class Search
    class Index
      class Object
        def initialize(object)
          @object = JSON.parse(object)
        end

        def id
          "#{@object['model'].to_s.downcase}_#{@object['id']}_#{@object['tag_id']}"
        end

        def to_h
          {
            object_type: @object['model'],
            object_id: @object['id'],
            object_created_at: @object['created_at'],
            tag_id: @object['tag_id'],
            tag_type: @object['tag_type'],
            tag_name: @object['tag_name'],
            last_updated: @object['updated_at']
          }
        end
      end
    end
  end
end