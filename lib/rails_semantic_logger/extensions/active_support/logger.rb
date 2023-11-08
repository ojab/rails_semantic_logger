require "active_support/logger"

module ActiveSupport
  # More hacks to try and stop Rails from being it's own worst enemy.
  class Logger
    class << self
      undef_method(:logger_outputs_to?)
      undef_method(:broadcast) if method_defined?(:broadcast)
    end

    # Prevent Console from trying to merge loggers
    def self.logger_outputs_to?(*args)
      true
    end

    # Prevent broadcasting since SemanticLogger already supports multiple loggers
    def self.broadcast(logger)
      Module.new
    end

    def self.new(*args, **kwargs)
      SemanticLogger[self]
    end
  end
end
