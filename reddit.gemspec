#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path "../library/reddit/version.rb", __FILE__

Gem::Specification.new do |spec|
  spec.name     = "reddit"
  spec.version  = Reddit::Version
  spec.summary  = "API implementation for Reddit"
  spec.license  = "MIT"
  spec.author   = "Mikkel Kroman"
  spec.email    = "mk@uplink.io"
  spec.files    = Dir["library/**/*.rb", "README", "LICENSE"]
  spec.homepage = "https://github.com/mkroman/reddit"

  spec.add_dependency "oauth2"
  spec.add_dependency "multi_json"
  spec.add_dependency "httparty"

  spec.require_path = "library"
  spec.required_ruby_version = ">= 1.9.1"
end