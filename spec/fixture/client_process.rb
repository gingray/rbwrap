#!/usr/bin/env ruby
$LOAD_PATH << '/Users/ivanlopatin/github/rbwrap/lib'
require 'rbwrap'

Rbwrap.configure do |conf|
  conf.socket_path = '/Users/ivanlopatin/github/rbwrap/spec/tmp/socket'
  conf.signal = 'USR1'
end

pid_file = '/Users/ivanlopatin/github/rbwrap/spec/tmp/pid'
pid = File.read(pid_file)

cont = true
Signal.trap('SIGINT') do
  cont = false
end

puts "pid use: #{pid}"

Process.kill('USR1', pid.to_i)
sleep 1

socket = UNIXSocket.new(Rbwrap.config.socket_path)
# kill -URG 78220
while cont do
  return unless cont

  data = nil
  begin
    data = STDIN.read_nonblock(4096)
    socket.write(data)
  rescue IO::WaitReadable
  end

  begin
    output = socket.read_nonblock(4096)
    puts "resp: #{output}"
  rescue IO::WaitReadable
  end
  IO.select([socket, STDIN], nil, nil, 1)
end
