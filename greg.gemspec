# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greg/version'

Gem::Specification.new do |spec|
  spec.name          = "greg"
  spec.version       = Greg::VERSION
  spec.authors       = ["Federico Iachetti"]
  spec.email         = ["iachetti.federico@gmail.com"]
  spec.summary       = %q{Simple generator.}
  spec.description   = %q{Simple generator.}
  spec.homepage      = "https://github.com/iachettifederico/greg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "matest", "~> 1.5.6"
  
  spec.add_runtime_dependency "fattr"
  spec.add_runtime_dependency "colin"
end
