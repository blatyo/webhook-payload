# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webhook/payload/version"

Gem::Specification.new do |s|
  s.name        = "webhook-payload"
  s.version     = Webhook::Payload::VERSION
  s.authors     = ["Allen Madsen"]
  s.email       = ["allen.c.madsen@gmail.com"]
  s.homepage    = "http://blatyo.github.com/webhook-payload"
  s.summary     = "This gem is a convenience wrapper for Github's webhook payload (https://help.github.com/articles/post-receive-hooks) that is triggered from a post receive hook. Feed it a hash of data and it will parse it into an object that you can use."
  s.description = "This gem is a convenience wrapper for Github's webhook payload (https://help.github.com/articles/post-receive-hooks) that is triggered from a post receive hook. Feed it a hash of data and it will parse it into an object that you can use. It also provides conversions from basic data types into more useful types like Time, URI, Pathname, and Boolean."

  s.rubyforge_project = "webhook-payload"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_runtime_dependency "virtus", ">= 0.5.0"
  s.add_runtime_dependency "multi_json"
end
