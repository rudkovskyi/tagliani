require 'active_record'
require 'active_support/concern'

module Tagliani
  module Models
    class << self
      attr_writer :tagged

      def tagged
        @tagged ||= []
      end
    end
  end
end