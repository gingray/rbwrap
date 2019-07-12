module Rbwrap
  class ErrorBase < StandardError; end
  # nodoc
  class ConstNotDefined < ErrorBase
    def initialize(const_name)
      super("CONST not defined: '#{const_name}'")
    end
  end

  # nodoc
  class WrongConstName < ErrorBase
    def initialize(const_name)
      super("Unacceptable CONST name: '#{const_name}'")
    end
  end

  # nodoc
  class WrongMethodName < ErrorBase
    def initialize(method_name)
      super("Method not exist: '#{method_name}'")
    end
  end

  # nodoc
  class ParserError < ErrorBase
    def initialize(original, buffer)
      super("Parser error: original: <#{original}> buffer: <#{buffer}>")
    end
  end

  class WrapMethodBuilerError < ErrorBase
    def initialize(msg, state)
      super("#{msg} -> #{state}")
    end
  end
end
