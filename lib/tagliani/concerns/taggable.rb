require_relative 'taggable/tags'

module Tagliani
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      def self.included(base)
        base.class_eval do
          after_save :inherit_tags
        end
      end

      def inherit_tags
        inherit_tags!
      end

      def inherit_tags!
      end

      def tags
        Tags.new(self)
      end
    end
  end
end