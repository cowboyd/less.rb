module Less
  
  class Error < ::StandardError
    
    def initialize(cause)
      if cause.is_a?(::Exception)
        @cause = cause
        super(cause.message)
      else
        super(cause)
      end
    end
    
    def cause
      @cause
    end
    
    def backtrace
      @cause ? @cause.backtrace : super
    end
    
  end
  
  class ParseError < Error; end
  
end