module Gossips
  module Concerns
    module Search
      class << self
        def search(args = {})
          Gossips::Search.new()
        end
      end
    end
  end
end