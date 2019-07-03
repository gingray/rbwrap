#!/usr/bin/env ruby
$LOAD_PATH << '/Users/ivanlopatin/github/rbwrap/lib'
require 'rbwrap'

Rbwrap.configure do |conf|
  conf.socket_path = '/Users/ivanlopatin/github/rbwrap/spec/tmp/socket'
  conf.signal = 'USR1'
end


cont = true
Signal.trap('SIGINT') do
  cont = false
end

# kill -URG 78220
while cont do
  sleep 1
  x = Rbwrap::Rbwrap.new
  puts "this value #{x.inspect} thread id: #{Thread.current.object_id} pid: #{Process.pid}"
end
