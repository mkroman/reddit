# encoding: utf-8

module Reddit
  class Client
    attr_accessor :options

    # Initialize a new client with a set of options.
    #
    # @params options [Hash] A set of options. 
    def initialize options = {}
      @options = options
    end


  end
end