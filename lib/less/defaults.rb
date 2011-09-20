
module Less
  module Defaults

    def defaults
      @defaults ||= {:paths => []}
    end

    def paths
      defaults[:paths]
    end
  end
end