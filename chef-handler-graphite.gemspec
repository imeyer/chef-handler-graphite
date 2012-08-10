# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chef-handler-graphite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "chef-handler-graphite"
  gem.version     = ChefHandlerGraphite::VERSION
  gem.authors     = ["Ian Meyer"]
  gem.email       = ["ianmmeyer@gmail.com"]
  gem.homepage    = "https://github.com/imeyer/chef-handler-graphite"
  gem.summary     = %q{Push reporting stats to Graphite}
  gem.description = %q{Push reporting stats to Graphite}

  gem.rubyforge_project = "chef-handler-graphite"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # specify any dependencies here; for example:
  gem.add_development_dependency "simple-graphite"
  gem.add_runtime_dependency "simple-graphite"
  gem.add_runtime_dependency "chef"
end
