# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schaldo/version'

Gem::Specification.new do |spec|
  spec.name          = "schaldo"
  spec.version       = Schaldo::VERSION
  spec.authors       = ["Adam Pahlevi"]
  spec.email         = ["adam.pahlevi@gmail.com"]
  spec.summary       = %q{Gem for Schaldo, balance management system as a service}
  spec.description   = %q{Gem for Schaldo, balance management system as a service}
  spec.homepage      = "http://adampahlevi.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rest-client", "~> 1.7"
  spec.add_development_dependency "activesupport", "~> 3.2"
end
