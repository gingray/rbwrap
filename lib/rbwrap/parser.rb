module Rbwrap
  # nodoc
  class Parser
    INSTANCE_METHOD = '.'.freeze
    CLASS_METHOD = '#'.freeze

    def initialize input
      @input = input
    end

    def call

    end

    def parse
      @method_type = nil
      @method_type = INSTANCE_METHOD if @input.include? INSTANCE_METHOD
      @method_type = CLASS_METHOD if @input.include? CLASS_METHOD
    end

    def template
      <<-EOF
        #{const_type} #{class_name}
          alias_method "rbwrap_original_#{method_name}", #{method_name}
          def #{method_name}(*args, &block)
            puts args
            "rbwrap_original_#{method_name}"(*args, &block)
          end
        end
      EOF
    end
  end
end
