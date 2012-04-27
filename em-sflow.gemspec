# -*- encoding: utf-8 -*-
require File.expand_path('../lib/em-sflow/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Norman Elton"]
  gem.email         = ["normelton@gmail.com"]
  gem.description   = "EventMachine-powered sFlow Collector"
  gem.summary       = "EventMachine-powered sFlow Collector"
  gem.homepage      = "http://github.com/normelton/em-sflow"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "em-sflow"
  gem.require_paths = ["lib"]
  gem.version       = EventMachine::SFlow::VERSION
  
  gem.extra_rdoc_files = ["README.rdoc"]
  gem.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "EM-SFLOW", "--main", "README.rdoc"]

  gem.add_runtime_dependency "eventmachine", ">= 0.12.10"
end
