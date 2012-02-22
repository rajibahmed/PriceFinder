# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "Ala/version"

Gem::Specification.new do |s|
  s.name        = "Ala"
  s.version     = Ala::VERSION
  s.authors     = ["Rajib Ahmed"]
  s.email       = ["cool_rajib@hotmail.com"]
  s.homepage    = "http://rajib.me"
  s.summary     = %q{This is a gem that reads file and generate price listing}
  s.description = %q{Awesome project for mobile parsing libraries}

  s.rubyforge_project = "Ala"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
