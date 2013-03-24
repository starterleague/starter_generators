# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'starter_generators/version'

Gem::Specification.new do |spec|
  spec.name          = "starter_generators"
  spec.version       = StarterGenerators::VERSION
  spec.authors       = ["Jeff Cohen"]
  spec.email         = ["jeff@starterleague.com"]
  spec.description   = %q{Generators for class.}
  spec.summary       = %q{Generators for class.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
