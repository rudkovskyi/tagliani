module Gossips
  module Concerns
    module Taggable
      class Tags < Array
        def initialize(parent = nil)
          @parent = parent
          @index = Gossips::Search::Index.new
          
          super(search)
        end

        def add(*objects)
          objects.flat_map do |hash|
            options = hash.slice(:name)

            begin
              record = Tag.find_or_initialize_by(options)
              record.save
            rescue ActiveRecord::RecordNotUnique
              record = Tag.find_by(options)
            end

            @index.add!({
              model: @parent.class.to_s,
              id: @parent.id,
              created_at: @parent.try(:created_at),
              tag_id: record.id,
              tag_kls: record.class.to_s,
              tag_type: record.sticker,
              tag_name: record.name,
              last_updated: Time.now
            })
          end
        end

        def search(body = {})
          body.deep_merge!({          
            query: {
              bool: {
                must: [
                  { match: { object_kls: @parent.class.to_s } },
                  { term: { object_id: @parent.id } }
                ]
              }
            }
          })

          Gossips::Search.new(body).serialize(type: 'tag')
        end
      end
    end
  end
end