require_relative "tagliani/configuration"
require_relative "tagliani/search"
require_relative "tagliani/version"
require_relative "tagliani/models"
require_relative "tagliani/concerns/taggable"
require_relative "tagliani/concerns/search"

require 'byebug'
require 'securerandom'
require 'redis'

module Tagliani
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

  def taggable(options = {})
    Models.tagged << to_s

    class_attribute :_tag_kls, :_async

    self._tag_kls = options[:tag_kls] || 'Tag'
    self._async = options[:async]

    class_eval do
      include Concerns::Taggable
    end
  end
end

require 'active_model/callbacks'
ActiveModel::Callbacks.include(Tagliani)

ActiveSupport.on_load(:active_record) do
  extend Tagliani
end
