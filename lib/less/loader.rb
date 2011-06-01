
module Less
  class Loader
    
    def initialize
      @cxt = V8::Context.new
      @path = Pathname(__FILE__).dirname.join('js','lib')
      @exports = {
        "path" => Path.new,
        "sys" => Sys.new,
        "fs" => Fs.new
      }
    end
    
    def require(path)
      unless exports = @exports[path]
        filename = path =~ /\.js$/ ? path : "#{path}.js"
        filepath = @path.join(filename)
        fail LoadError, "no such file: #{filename}" unless filepath.exist?
        load = @cxt.eval("(function(require, exports, __dirname) {require.paths = [];#{File.read(filepath)}})", filepath.expand_path)
        @exports[path] = exports = @cxt['Object'].new
        load.call(method(:require), exports, Dir.pwd)
      end
      return exports
    end
    
    class Path
      def join(*components)
        File.join(*components)
      end
    end
    class Sys
    end
    class Fs
    end
  end
end