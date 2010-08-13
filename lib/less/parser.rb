
require 'v8'

module Less
  class Parser
    LESSJS = File.dirname(__FILE__) + '/../../deps/less.js/dist/less-1.0.33.js'
    def initialize
      @v8 = V8::Context.new
      @window = @v8['window'] = @v8.scope
      @v8.eval <<-JS
window.location = {
  port: ''
}
JS
      @v8.load(LESSJS)
    end
  end
end
