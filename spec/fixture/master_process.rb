#!/usr/bin/env ruby
$LOAD_PATH << '/Users/ivanlopatin/github/rbwrap/lib'
require 'rbwrap'

Rbwrap.configure do |conf|
  conf.socket_path = '/Users/ivanlopatin/github/rbwrap/spec/tmp/socket'
  conf.signal = 'USR1'
end
pid_file = '/Users/ivanlopatin/github/rbwrap/spec/tmp/pid'

File.open pid_file, 'w' do |f|
  f.write Process.pid
end
# Test.call
class Test
  attr_accessor :var
  def initialize
    @var = []
  end

  def call(x)
    puts "this is :#{x}"
  end
end


cont = true
Signal.trap('SIGINT') do
  cont = false
end

# kill -URG 78220
while cont do
  sleep 1
  x = Test.new
  puts "this value #{x.inspect} thread id: #{Thread.current.object_id} pid: #{Process.pid}"
  x.call(10)
end
