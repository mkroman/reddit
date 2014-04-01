# encoding: utf-8

require 'faraday'
require 'faraday_middleware'
require 'multi_json'

require 'reddit/version'
require 'reddit/client'

module Reddit
  # Initialize a singleton instance of Reddit::Client.
  #
  # @see Reddit::Client
  def self.initialize client_id, client_secret, options = {}
    @_client ||= Client.new client_id, client_secret, options
  end

  # Returns the initialized client, if it's been initialized.
  #
  # @see Reddit.initialize
  def self.client
    @_client
  end
end
