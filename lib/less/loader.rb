require 'pathname'
require 'commonjs'

module Less
  class Loader
    
    attr_reader :environment
    
    def initialize
      context_wrapper = Less::JavaScript.context_wrapper.instance
      @context = context_wrapper.unwrap
      @context['process'] = Process.new
      @context['console'] = Console.new
      path = Pathname(__FILE__).dirname.join('js', 'lib')
      @environment = CommonJS::Environment.new(@context, :path => path.to_s)
      @environment.native('path', Path.new)
      @environment.native('util', Sys.new)
      @environment.native('fs', Fs.new)
    end
    
    def require(module_id)
      @environment.require(module_id)
    end
    
    # stubbed JS modules required by less.js
    
    class Path
      def join(*components)
        File.join(*components)
      end

      def dirname(path)
        File.dirname(path)
      end

      def basename(path)
        File.basename(path)
      end
    end
    
    class Sys
      def error(*errors)
        raise errors.join(' ')
      end
    end

    class Fs
      def statSync(path)
        File.stat(path)
      end

      def readFile(path, encoding, callback)
        callback.call(nil, File.read(path))
      end
    end

    class Process
      def exit(*args)
      end
    end

    class Console
      def self.log(*msgs)
        puts msgs.join(', ')
      end
    end
    
  end
end