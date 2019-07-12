module Rbwrap
  # nodoc
  class WrapObject
    INSTANCE_METHOD = :instance
    CLASS_METHOD = :klass
    attr_accessor :method_type, :method_name

    def initialize
      @const = []
      @method_name = nil
      @method_type = nil
    end

    def add_namespace(name)
      @const << name
    end

    def namespace
      "::#{@const.join('::')}"
    end

    def self.build(str)
      parser = WrapMethodParser.new
      parser.parse str
      builder = WrapMethodBuilder.new parser.tokens
      builder.build
    end
  end
end
