# encoding: utf-8

module Reddit
  class Client
    DefaultOptions = {
      :verbose => false,
      :http_adapter => Faraday.default_adapter
    }

    OAuthTokenError = Class.new StandardError

    attr_accessor :options
    attr_accessor :access_scope
    attr_accessor :access_token
    attr_accessor :access_expiry

    # Initialize a new client with a set of options.
    #
    # @param client_id     [String] The OAuth client id.
    # @param client_secret [String] The OAuth client secret.
    # @param options       [Hash] A set of options. 
    # @option options [Boolean] :verbose (false) Enable verbose mode.
    # @option options [Symbol] :http_adapter (Faraday.default_adapter)
    #   The HTTP adapter to use with Faraday.
    def initialize client_id, client_secret, options = {}
      @client_id = client_id
      @client_secret = client_secret
      @session = {}
      @options = DefaultOptions.merge options
      @access_scope = nil
      @access_token = nil
      @access_expiry = 0

      @connection = Faraday.new "https://ssl.reddit.com/", ssl: { verify: false } do |connection|
        connection.request :url_encoded
        connection.response :logger if @options[:verbose]
        connection.adapter @options[:http_adapter]
      end
    end

    # Authenticate with an account.
    #
    # @param username [String] The account name.
    # @param password [String] The account password.
    def authenticate username, password
      connection = @connection.dup
      connection.basic_auth @client_id, @client_secret

      params = {
        :username => username,
        :password => password,
        :grant_type => :password
      }

      response = connection.post "/api/v1/access_token", params
      body = MultiJson.load response.body

      if body['access_token']
        @access_scope = body['scope']
        @access_token = body['access_token']
        @access_expiry = Time.now + body['expires_in']
      else
        raise OAuthTokenError, body['error']
      end
    end
  end
end