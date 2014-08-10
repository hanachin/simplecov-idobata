# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplecov/idobata/version'

Gem::Specification.new do |spec|
  spec.name          = "simplecov-idobata"
  spec.version       = SimpleCov::Formatter::IdobataFormatter::VERSION
  spec.authors       = ["Seiei Higa"]
  spec.email         = ["hanachin@gmail.com"]
  spec.summary       = %q{report your test coverage to idobata.io.}
  spec.homepage      = "https://github.com/hanachin/simplecov-idobata"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "simplecov"
  spec.add_dependency "idobadge"
  spec.add_dependency "idobata_hook"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rake"
end
