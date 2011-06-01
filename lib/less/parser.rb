
require 'v8'

module Less
  class Parser

    def initialize(options = {})
      stringy = {}
      options.each do |k,v|
        stringy[k.to_s] = v.is_a?(Array) ? v.map(&:to_s) : v.to_s
      end
      @parser = Less.Parser.new(stringy)
    end

    def parse(less)
      error,tree = nil
      @parser.parse(less, lambda {|e, t| error = e; tree = t})
      return Tree.new(tree) if tree
    rescue V8::JSError => e
      raise ParseError.new(e)
    end

  end

  class Tree
    def initialize(tree)
      @tree = tree
    end

    def to_css
      @tree.toCSS()
    end
  end
  
  class ParseError < StandardError
    
    def initialize(error)
      super(error.message)
      @backtrace = error.backtrace
    end
  
    def backtrace
      @backtrace
    end
  end
end
