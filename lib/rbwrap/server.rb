module Rbwrap
  class Server
    attr_reader :server

    def initialize(socket_path)
      @socket_path = socket_path
      @clients = []
      File.unlink(@socket_path) if File.exist?(@socket_path) && File.socket?(@socket_path)
    end

    def call
      @server = UNIXServer.new @socket_path
      while true do
        readable, writeable = IO.select([@server] + @clients, nil, nil, 5)
        next unless readable

        readable.each do |sock|
          begin
            if sock == @server
              @clients << @server.accept_nonblock
            else
              data = sock.read_nonblock(4096)
              resp = eval(data_to_eval)
              sock.write(resp || '')
              puts "echo data: #{data}"
            end
            socket = @server.accept_nonblock
            @clients << socket
          rescue EOFError
            puts "connection has been closed"
            sock.close
            @clients.delete(sock)
          rescue Errno::EAGAIN, Errno::ECONNABORTED, Errno::EINTR, Errno::EWOULDBLOCK
          end
        end
      end
    end

    def data_to_eval
      "class ::Test; def initialize; @var = {}; end end"
    end
  end
end
