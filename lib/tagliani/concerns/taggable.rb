require_relative "taggable/tags"

module Tagliani
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      def tags
        Tags.new(self)
      end
    end
  end
end