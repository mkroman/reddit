# encoding: utf-8

require 'vcr'
require 'cgi'
require 'yaml'

$:.unshift File.dirname(__FILE__) + '/../library'
require 'reddit'

$config = { 
  'client_id' => ENV['REDDIT_ID'],
  'client_secret' => ENV['REDDIT_SECRET'],
  'username' => ENV['REDDIT_USER'],
  'password' => ENV['REDDIT_PASS'],
}

VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = File.join File.dirname(__FILE__), 'fixtures/cassettes'

  c.filter_sensitive_data('<USERNAME>') { CGI.escape $config['username'] }
  c.filter_sensitive_data('<PASSWORD>') { CGI.escape $config['password'] }
  c.filter_sensitive_data('<CLIENT_ID>') { CGI.escape $config['client_id'] }
  c.filter_sensitive_data('<CLIENT_SECRET>') { CGI.escape $config['client_secret'] }

  authorization = $config['client_id'] + ":" + $config['client_secret']
  c.filter_sensitive_data('<AUTH_KEY>') { Base64.encode64(authorization).strip }

  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end