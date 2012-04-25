module Less
  
  # Convert lesscss source into an abstract syntax Tree
  class Parser

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
      @parser = Less::JavaScript.exec { Less['Parser'].new(stringy) }
    end

    # Convert `less` source into a abstract syntaxt tree
    # @param [String] less the source to parse
    # @return [Less::Tree] the parsed tree
    def parse(less)
      error, tree = nil, nil
      Less::JavaScript.exec do
        @parser.parse(less, lambda { |*args| # (error, tree)
          # v8 >= 0.10 passes this as first arg :
          if args.size > 2
            error, tree = args[-2], args[-1]
          elsif args.last.respond_to?(:message) && args.last.message
            # might get invoked as callback(error)
            error = args.last
          else
            error, tree = *args
          end
          fail error.message unless error.nil?
        })
      end
      Tree.new(tree) if tree
    end
    
    private
    
    # Abstract LessCSS syntax tree Less. Mainly used to emit CSS
    class Tree

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
        Less::JavaScript.exec { @tree.toCSS(options) }
      end
      
    end
    
  end
  
end
