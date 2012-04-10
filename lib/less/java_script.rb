module Less
  module JavaScript
    
    def self.default_context_class
      if defined?(JRUBY_VERSION)
        require 'less/java_script/rhino_context'
        RhinoContext
      else
        require 'less/java_script/v8_context'
        V8Context
      end
    end
    
    @@context_class = nil
    
    def self.context_class
      @@context_class ||= default_context_class
    end
    
    def self.context_class=(klass)
      @@context_class = klass
    end
    
    # execute a block as JS
    def self.exec(&block)
      context_class.instance.exec(&block)
    end
    
    def self.eval(source)
      context_class.instance.eval(source)
    end
    
  end
end