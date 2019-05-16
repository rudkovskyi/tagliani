module Gossips
  class Configuration
    class Elasticsearch < Struct.new(:url, :index, :refresh, :log)
      def initialize
        self.url = "http://localhost:9200"
        self.index = "gossips"
        self.refresh = false
        self.log = false
      end
    end
  end
end