module Tagliani
  module Concerns
    module Taggable
      class Tags < Array
        def initialize(parent = nil)
          @parent = parent
          @index = Tagliani::Search::Index.new
          @tag_kls = @parent.class._tag_kls.constantize
          @async = @parent.class._async
          
          super(search)
        end

        def add(*objects)
          objects.flat_map do |hash|
            options = hash.slice(:name)

            begin
              record = @tag_kls.find_or_initialize_by(options)
              record.save
            rescue ActiveRecord::RecordNotUnique
              record = @tag_kls.find_by(options)
            end

            @index.add!({
              object_kls: parent_kls,
              object_id: @parent.id,
              created_at: @parent.try(:created_at),
              tag_id: record.id,
              tag_kls: record.class.to_s,
              tag_type: record.sticker,
              tag_name: record.name,
              last_updated: Time.now
            }, async: @async)
          end
        end

        def search(body: {}, where: nil)
          body.deep_merge!({
            query: {
              bool: {
                must: [
                  { match: { object_kls: parent_kls } },
                  { term: { object_id: @parent.id } }
                ]
              }
            }
          })

          Tagliani::Search.new(body: body, where: where).serialize(type: 'tag')
        end

        def inherit
          root.each do |object|
            next if object.nil?
            
            self.class.new(object).each do |ref|
              add(name: ref.name)
            end
          end
        end

        def root
          klasses = []
  
          if @parent._inherit.respond_to?(:each)
            klasses = @parent._inherit
          else
            klasses << @parent._inherit
          end
  
          objects = klasses.flat_map do |method|
            next if method.nil?
            @parent.send(method)
          end
  
          objects.compact
        end

        private

        def parent_kls
          @parent.class.base_class.to_s 
        end
      end
    end
  end
end