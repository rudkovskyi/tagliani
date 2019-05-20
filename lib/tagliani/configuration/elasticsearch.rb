module Tagliani
  class Configuration
    class Elasticsearch < Struct.new(:url, :index, :refresh, :log)
      def initialize
        self.url = "http://localhost:9200"
        self.index = "tagliani"
        self.refresh = false
        self.log = false
      end
    end
  end
end