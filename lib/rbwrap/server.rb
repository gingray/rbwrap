require 'socket'
require 'fileutils'

module Rbwrap
  class Server
    attr_reader :socket

    def initialize(socket_path)
      @socket_path = socket_path
      File.unlink(@socket_path) if File.exist?(@socket_path) && File.socket?(@socket_path)
    end

    def call
      UNIXSocket
      @socket = UNIXServer.new @socket_path
      @socket.accept
      while true
        data = @socket.read
        resp = eval(data)
        puts resp
      end
    end

  end
end
