module Application
  class Error < RuntimeError

    attr_reader :properties

    def initialize message = nil, properties = {}
      @properties = properties
    end

  end
end