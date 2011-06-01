$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Less
  require 'v8'
  require 'less/parser'
  require 'less/loader'
  require 'less/version'

  @loader = Less::Loader.new
  @less = @loader.require('less/index')

  def self.method_missing(name, *args)
    if args.length == 0 && value = @less[name]
      return value
    else
      super(name, *args)
    end
  end
end