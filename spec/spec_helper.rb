require "bundler/setup"
require "rbwrap"
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class TestConst
  class NestedConst
    def self.method_2
    end
    def method_1
    end
  end
end

class Test
  attr_accessor :var
  def initialize
    @var = []
  end

  def call(x)
    puts "this is :#{x}"
  end
end
