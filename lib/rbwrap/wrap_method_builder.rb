module Rbwrap
  class WrapMethodBuilder
    def initialize(tokens)
      @tokens = tokens
      if @tokens.first[0] != WrapMethodParser::NAMESPACE
        @tokens.unshift [WrapMethodParser::NAMESPACE, WrapMethodParser::NAMESPACE]
      end
      @current_token = @tokens.shift
      @result = WrapObject.new
    end

    def build
      until @tokens.empty?
        if state == WrapMethodParser::NAMESPACE
          eat([WrapMethodParser::CONST_NAME])
          @result.add_namespace(@current_token[1])
          next
        end

        if state == WrapMethodParser::CONST_NAME
          eat([WrapMethodParser::NAMESPACE, WrapMethodParser::INSTANCE_METHOD, WrapMethodParser::CLASS_METHOD])
          @result.method_type = WrapObject::INSTANCE_METHOD if @current_token[0] == WrapMethodParser::INSTANCE_METHOD
          @result.method_type = WrapObject::CLASS_METHOD if @current_token[0] == WrapMethodParser::CLASS_METHOD
          next
        end

        if state == WrapMethodParser::INSTANCE_METHOD || @state == WrapMethodParser::CLASS_METHOD
          eat([WrapMethodParser::METHOD_NAME])
          @result.method_name = @current_token[1]
          next
        end

        raise WrapMethodBuilerError.new 'Unexpected state', state
      end
      @result
    end

    def state
      @current_token[0]
    end

    def eat(token_types)
      @current_token = @tokens.shift
      unless token_types.include? @current_token.first
        raise WrapMethodBuilerError.new 'Unexpected token', [@current_token, token_types]
      end
    end
  end
end
