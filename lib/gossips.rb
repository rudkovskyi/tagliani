require_relative "gossips/configuration"
require_relative "gossips/search"
require_relative "gossips/version"

require 'byebug'
require 'securerandom'
require 'redis'

module Gossips
  class Error < StandardError; end
  
  class << self
    attr_reader :config

    def configure
      @config ||= Configuration.new
      yield(@config)
    end

    def redis
      @redis ||= Redis.new(url: config.redis.url)
    end
  end
end
