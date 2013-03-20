# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rabbit_viewer/version'

Gem::Specification.new do |spec|
  spec.name          = "rabbit_viewer"
  spec.version       = RabbitViewer::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{RabbitViewer is file viewer. Support a multi format.}
  spec.description   = spec.summary # FIXME
  spec.homepage      = "https://github.com/myokoym/rabbit_viewer"
  spec.license       = "GPLv2+"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("rabbit", ">= 2.0.2")

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
