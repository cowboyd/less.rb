require 'commonjs'

module Less
  class Loader
    include CallJS

    attr_reader :environment

    def initialize
      @cxt = V8::Context.new
      @environment = CommonJS::Environment.new(@cxt, :path => Pathname(__FILE__).dirname.join('js','lib').to_s)
      @environment.native('path', Path.new)
      @environment.native('util', Sys.new)
      @environment.native('fs', Fs.new)

      @cxt['process'] = Process.new
      @cxt['console'] = Console.new
    end

    def require(module_id)
      @environment.require(module_id)
    end

    class Path
      def join(*components)
        File.join(*components)
      end

      def dirname(path)
        File.dirname(path)
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
      def log(*msgs)
        puts msgs.join(',')
      end
    end
  end
end