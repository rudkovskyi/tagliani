module Gossips
  class Configuration
    class Tag < Struct.new(:types)
			def initialize
				self.types = %i[default inheritable]
			end
		end
	end
end