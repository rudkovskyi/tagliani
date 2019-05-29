require_relative "taggable/tags"

module Tagliani
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      def self.included(base)
        base.class_eval do
          after_save :inherit_tags, if: proc { self.tags.root }
        end
      end

      def tags
        Tags.new(self)
      end

      private

      def inherit_tags
        tags.inherit
      end
    end
  end
end