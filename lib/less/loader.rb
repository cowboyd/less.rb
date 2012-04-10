require 'pathname'

module Less
  class Loader
    
    attr_reader :environment
    
    def initialize
      @path = Pathname(__FILE__).dirname.join('js', 'lib', 'less')
      @current_path = @path
      @exports = { # 'modules' required by less.js :
        "path" => Path.new, "util" => Sys.new, "fs" => Fs.new, 
      }
      @requires = {}
      @process = Process.new
      @context = Less::JavaScript.context_class.new # 'console' => Console
      
      @exports.each do |name, export| 
        @exports[name] = @context.wrap(export)
      end if @context.respond_to?(:wrap)
    end

    def require(id)
      id = id[0...-3] if id =~ /\.js$/
      unless exports = @exports[id]
        filepath = @path.join(filename = "#{id}.js")
        unless filepath.exist?
          filepath = @current_path.join(filename)
          fail LoadError, "no such file: #{filename}" unless filepath.exist?
        end
        
        # aliasing e.g. require './tree' and
        # than in a subdir require '../tree'
        if req_id = @requires[filepath]
          return @exports[id] = @exports[req_id]
        end
        @requires[filepath] = id
        
        @current_path = filepath.dirname
        @exports[id] = exports = @context.eval("{}")
        load_js = "(function(process, require, exports, __dirname) { require.paths = []; #{File.read(filepath)} })"
        @context.call(load_js, @process, method(:require), exports, @current_path.to_s, :source_name => filepath.expand_path.to_s)
      end
      exports
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