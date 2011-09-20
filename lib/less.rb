require 'v8'
require 'pathname'
require 'less/parser'
require 'less/loader'
require 'less/version'
require 'less/defaults'

module Less
  extend Less::Defaults

  @loader = Less::Loader.new
  @less = @loader.require('less/index')

  def self.Parser
    @less['Parser']
  end

end