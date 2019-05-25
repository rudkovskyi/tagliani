module Tagliani
  class Configuration
    class Tag < Struct.new(:types)
      def initialize
        self.types = %i[default]
      end
    end
  end
end