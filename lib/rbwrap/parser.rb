module Rbwrap
  # nodoc
  class Parser
    def initialize input
      @input = input
    end

    def call

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
