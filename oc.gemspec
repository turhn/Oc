# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oc/version'

Gem::Specification.new do |spec|
  spec.name          = "oc"
  spec.version       = Oc::VERSION
  spec.authors       = ["Sedat Ciftci"]
  spec.email         = ["me@sedat.us"]
  spec.summary       = %q{DigitalOcean Command Line Tools}
  spec.description   = %q{DigitalOcean Command Line Tools}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency      'commander', '~> 4.2.0'
  spec.add_runtime_dependency      'terminal-table', '~> 1.4.5'
  spec.add_runtime_dependency      'netrc', '~> 0.7.7'
  spec.add_runtime_dependency      'colorize'
  spec.add_runtime_dependency      'barge'


  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
