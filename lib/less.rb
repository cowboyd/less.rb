
require 'less/defaults'
require 'less/errors'
require 'less/loader'
require 'less/parser'
require 'less/version'
require 'less/java_script'

module Less
  extend Less::Defaults
  
  LESS = Less::Loader.new.require('index') # 'less/index'

  def self.[](name)
    LESS[name]
  end
  
  def self.Parser
    self['Parser']
  end

end