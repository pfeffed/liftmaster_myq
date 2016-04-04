# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liftmaster_myq/version'

Gem::Specification.new do |spec|
  spec.name          = "liftmaster_myq"
  spec.version       = LiftmasterMyq::VERSION
  spec.authors       = ["Trung Vo"]
  spec.email         = ["xxx@xxx.org"]
  spec.description   = %q{Unofficial Liftmaster MyQ Controller}
  spec.summary       = %q{Gem to access and control the Liftmaster MyQ garage door system.}
  spec.homepage      = "http://github.com/pfeffed/liftmaster_myq"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.12.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
