# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "chef-handler-graphite"
  s.version     = "1.1.0"
  s.authors     = ["Ian Meyer"]
  s.email       = ["ianmmeyer@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Push reporting stats to Graphite}
  s.description = %q{Push reporting stats to Graphite}

  s.rubyforge_project = "chef-handler-graphite"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "simple-graphite"
  s.add_runtime_dependency "simple-graphite"
  s.add_runtime_dependency "chef"
end
