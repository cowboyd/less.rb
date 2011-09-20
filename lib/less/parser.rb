
module Less

  # Utility for calling into the JavaScript runtime.
  module CallJS

    # @private
    # Wrap JavaScript invocations with uniform error handling
    #
    # @yield code to wrap
    def calljs
      lock do
        yield
      end
    rescue V8::JSError => e
      raise ParseError.new(e)
    end

    # @private
    # Ensure proper locking before entering the V8 API
    #
    # @yield code to wrap in lock
    def lock
      result, exception = nil, nil
      V8::C::Locker() do
        begin
          result = yield
        rescue Exception => e
          exception = e
        end
      end
      if exception
        raise exception
      else
        result
      end
    end
  end

  # Convert lesscss source into an abstract syntax Tree
  class Parser
    include CallJS

    # Construct and configure new Less::Parser
    #
    # @param [Hash] opts configuration options
    # @option opts [Array] :paths a list of directories to search when handling \@import statements
    # @option opts [String] :filename to associate with resulting parse trees (useful for generating errors)
    def initialize(options = {})
      stringy = {}
      Less.defaults.merge(options).each do |k,v|
        stringy[k.to_s] = v.is_a?(Array) ? v.map(&:to_s) : v.to_s
      end
      lock do
        @parser = Less.Parser.new(stringy)
      end
    end

    # Convert `less` source into a abstract syntaxt tree
    # @param [String] less the source to parse
    # @return [Less::Tree] the parsed tree
    def parse(less)
      calljs do
        error,tree = nil
        @parser.parse(less, lambda {|e, t|
          error = e; tree = t
        })
        Tree.new(tree) if tree
      end
    end
  end

  # Abstract LessCSS syntax tree Less. Mainly used to emit CSS
  class Tree
    include CallJS
    # Create a tree from a native javascript object.
    # @param [V8::Object] tree the native less.js tree
    def initialize(tree)
      @tree = tree
    end

    # Serialize this tree into CSS.
    # By default this will be in pretty-printed form.
    # @param [Hash] opts modifications to the output
    # @option opts [Boolean] :compress minify output instead of pretty-printing
    def to_css(options = {})
      calljs do
        @tree.toCSS(options)
      end
    end
  end

  # Thrown whenever an error occurs parsing
  # and/or serializing less source. It is intended
  # to wrap a native V8::JSError
  class ParseError < StandardError

    # Copies over `error`'s message and backtrace
    # @param [V8::JSError] error native error
    def initialize(error)
      super(error.message)
      @backtrace = error.backtrace
    end

    # @return [Array] the backtrace frames
    def backtrace
      @backtrace
    end
  end
end
