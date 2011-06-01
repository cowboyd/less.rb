
require 'v8'

module Less
  class Parser

    def initialize(options = {})
      @options = options
      @parser = Less.Parser.new
    end

    def parse(less)
      error,tree = nil
      @parser.parse(less, lambda {|e, t| error = e; tree = t})
      return Tree.new(tree) if tree
      fail ParseError, error if error
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
  
  ParseError = Class.new(StandardError)
end
