$:.push File.expand_path("../lib", __FILE__)
require "duo-rest/version"
require "rubygems"
require "bundler/setup"

Gem::Specification.new do |s|
  s.name        = 'duo-rest'
  s.version     = DuoRest::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2012-06-27'
  s.summary     = "Duo Security Rest Api"
  s.description = "Gem interface for Duo security rest api"
  s.authors     = ["Kelly Mahan"]
  s.email       = 'kmahan@kmahan.com'
  s.homepage    = 'http://rubygems.org/gems/duo-rest'
  
  s.files       = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  
  s.add_development_dependency("pry")
end