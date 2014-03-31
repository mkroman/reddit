# encoding: utf-8

require 'vcr'
require 'cgi'
require 'yaml'

$:.unshift File.dirname(__FILE__) + '/../library'
require 'reddit'

$config = { 'username' => ENV['REDDIT_USER'], 'password' => ENV['REDDIT_PASS'] }

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = File.join File.dirname(__FILE__), 'fixtures/cassettes'

  c.filter_sensitive_data('<USERNAME>') { CGI.escape $config['username'] }
  c.filter_sensitive_data('<PASSWORD>') { CGI.escape $config['password'] }
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end