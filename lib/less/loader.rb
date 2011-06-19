
module Less
  class Loader
    include CallJS

    def initialize
      lock do
        @cxt = V8::Context.new
        @path = Pathname(__FILE__).dirname.join('js','lib')
        @exports = {
          "path" => Path.new,
          "sys" => Sys.new,
          "fs" => Fs.new
        }
        @process = Process.new
        @cxt['console'] = Console.new
      end
    end
    
    def require(path)
      unless exports = @exports[path]
        filename = path =~ /\.js$/ ? path : "#{path}.js"
        filepath = @path.join(filename)
        fail LoadError, "no such file: #{filename}" unless filepath.exist?
        lock do
          load = @cxt.eval("(function(process, require, exports, __dirname) {require.paths = [];#{File.read(filepath)}})", filepath.expand_path)
          @exports[path] = exports = @cxt['Object'].new
          load.call(@process, method(:require), exports, Dir.pwd)
        end
      end
      return exports
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