module Rbwrap
  # nodoc
  class Parser
    INSTANCE_METHOD = '.'.freeze
    CLASS_METHOD = '#'.freeze
    IS_MODULE = 'module'.freeze
    IS_CLASS = 'class'.freeze

    attr_accessor :method_type, :method_name, :const_name, :const_type

    def initialize input
      @input = input.strip
    end

    def call
      parse
    end

    def parse
      @method_type = nil
      @method_type = INSTANCE_METHOD if @input.include? INSTANCE_METHOD
      @method_type = CLASS_METHOD if @input.include? CLASS_METHOD
      raise 'wrong format' unless @method_type

      @const_name, @method_name = @input.split @method_type
      validate_const_name(@const_name)
      top_level_const = @const_name.split('::').first
      @const_type = module?(top_level_const) ? IS_MODULE : IS_CLASS
      validate_method_name(@method_name)
      template
    end

    def module?(str)
      const = Kernel.const_get(str)
      const.instance_of?(Module)
    end

    def validate_const_name(str)
      return true if Kernel.const_defined?(str)

      raise ConstNotDefined, str
    rescue NameError
      raise WrongConstName, str
    end

    def validate_method_name(str)
      const = Kernel.const_get(@const_name)
      return if @method_type == INSTANCE_METHOD && const.method_defined?(str)
      return if @method_type == CLASS_METHOD && const.respond_to?(str)

      raise WrongMethodName, str
    end

    def template
      <<-EOF
        #{const_type} ::#{const_name}
          alias_method :rbwrap_original_#{method_name}, :#{method_name}
          def #{method_name}(*args, &block)
            puts args
            rbwrap_original_#{method_name}(*args, &block)
          end
        end
      EOF
    end
  end
end
