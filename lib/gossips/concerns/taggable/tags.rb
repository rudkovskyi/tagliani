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
              tag_object: record.class.to_s,
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
                  { match: { object_type: @parent.class.to_s } },
                  { term: { object_id: @parent.id } }
                ]
              }
            }
          })

          parse(Gossips::Search.new(body).response['hits']['hits'])
        end

        private

        def parse(hits)
          models = {}

          hits.each do |entry|
            entry_source = entry['_source']
            class_name = entry_source['tag_object']
            models[class_name] ||= []
            models[class_name] << entry_source['tag_id']
          end

          models.flat_map do |model, ids|
            model.constantize.where(id: ids)
          end
        end
      end
    end
  end
end