$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Less

  require 'v8'
  require 'pathname'
  require 'less/parser'
  require 'less/loader'
  require 'less/version'

  @loader = Less::Loader.new
  @less = @loader.require('less/index')

  def self.Parser
    @less['Parser']
  end

end