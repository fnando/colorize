# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "colorize/version"

Gem::Specification.new do |s|
  s.name        = "colorize"
  s.version     = Colorize::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/colorize"
  s.summary     = "Make your $stdout colorful"
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
