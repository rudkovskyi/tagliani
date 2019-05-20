module Tagliani
  class Configuration
    class Redis < Struct.new(:url, :queue, :length)
      def initialize
        self.url = "redis://localhost:6379/tagliani"
        self.queue = "tagliani"
        self.length = 200
      end
    end
  end
end