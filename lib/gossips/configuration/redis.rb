module Gossips
  class Configuration
    class Redis < Struct.new(:url, :queue, :length)
      def initialize
        self.url = "redis://localhost:6379/gossips"
        self.queue = "gossips"
        self.length = 200
      end
    end
  end
end