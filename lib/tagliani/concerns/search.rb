module Tagliani
  module Concerns
    module Search
      extend ActiveSupport::Concern

      module ClassMethods
        def search(body: {}, where: nil)
          Tagliani::Search.new(body: body, where: where).serialize(type: 'object')
        end
      end
    end
  end
end