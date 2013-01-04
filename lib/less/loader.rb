require 'pathname'
require 'commonjs'
require 'net/http'
require 'uri'

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
      @environment.native('url', Url.new)
      @environment.native('http', Http.new)
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

    class Url
      def resolve(*args)
        URI.join(*args)
      end

      def parse(url_string)
        u = URI.parse(url_string)
        {'pathname' => u.path, 'host' => u.host, 'port' => u.port}
      end
    end
    
    class Http
      def get(options, callback)
        #first arg should actually support an options object, but less.js doesn't rely on this right now
        raise ArgumentError, 'options argument can currently only be string' if !options.is_string?
        uri = URI.parse(options)
        response = Net::HTTP.get_response(uri)
        ServerResponse.new(response.body, response.status_code)
      end
    end

    class ServerResponse
      attr_accessor :statusCode
      attr_accessor :data   #faked because ServerResponse acutally implements WriteableStream

      def initialize(data, status_code)
        @data = data
        @statusCode = status_code
      end

      def on(event, callback)
        case event
        when 'data'
          callback.call(@data)
        when 'end'
          callback.call()
        end
      end
    end
  end
end