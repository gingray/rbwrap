module Rbwrap
  class ParserNew
    NAMESPACE = '::'.freeze
    CONST_NAME = 'CONST'.freeze
    INSTANCE_METHOD = '.'.freeze
    CLASS_METHOD = '#'.freeze
    METHOD_NAME = 'METHOD_NAME'.freeze
    attr_reader :tokens

    def initialize
      @tokens = []
    end

    def parse(str)
      stream = str.strip
      binding.pry
      buffer = ''

      while !stream.empty?
        buffer << stream.slice!(0)

        if buffer == NAMESPACE
          tokens << [NAMESPACE, buffer]
          buffer = ''
          next
        end

        if buffer == INSTANCE_METHOD
          tokens << [INSTANCE_METHOD, buffer]
          buffer = ''
          next
        end

        if buffer == CLASS_METHOD
          tokens << [CLASS_METHOD, buffer]
          buffer = ''
          next
        end

        if buffer =~ /[[:upper:]]/
          ch = stream.slice!(0)
          while !ch.nil? && ch =~ /[[:alnum:]]/
            buffer << ch
            ch = stream.slice!(0)
          end
          stream.prepend ch if ch
          tokens << [CONST_NAME, buffer]
          buffer = ''
          next
        end

        if buffer =~ /[[:lower:]]/
          ch = stream.slice!(0)
          while !ch.nil? && ch =~ /[[a-z_!?0-9]]/
            buffer << ch
            ch = stream.slice!(0)
          end
          stream.prepend ch if ch
          tokens << [METHOD_NAME, buffer]
          buffer = ''
          next
        end
      end
      binding.pry
    end
  end
end
