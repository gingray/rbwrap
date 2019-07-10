require 'socket'
require "rbwrap/version"
require "rbwrap/exceptions"
require "rbwrap/configuration"
require "rbwrap/server"
require "rbwrap/parser"
require "rbwrap/rbwrap"

module Rbwrap
  class << self
    attr_reader :config, :server

    def configure(&block)
      return unless block_given?

      @config = Configuration.new
      yield(@config)

      Kernel.trap(config.signal) do
        Thread.new do
          puts "create socket server"
          @server = Server.new(config.socket_path)
          @server.call
        end
      end
    end
  end
end
