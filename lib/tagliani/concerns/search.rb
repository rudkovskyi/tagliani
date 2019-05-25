module Tagliani
  module Concerns
    module Search
      extend ActiveSupport::Concern

      module ClassMethods
        def search(args = {})
          Tagliani::Search.new(args).serialize(type: 'object')
        end
      end
    end
  end
end