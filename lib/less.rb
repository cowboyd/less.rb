
require 'less/defaults'
require 'less/errors'
require 'less/loader'
require 'less/parser'
require 'less/version'
require 'less/java_script'

module Less
  extend Less::Defaults
  
  # NOTE: keep the @loader as less-rails depends on 
  # it as it overrides some less/tree.js functions!
  @loader = Less::Loader.new
  @less = @loader.require('less/index')

  def self.[](name)
    @less[name]
  end
  
  def self.Parser
    self['Parser']
  end

end