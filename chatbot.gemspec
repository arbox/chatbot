# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chatbot/version"

Gem::Specification.new do |s|
  s.name        = "chatbot"
  s.version     = Chatbot::VERSION
  s.authors     = ["Andrei Beliankou"]
  s.email       = ["arbox@yandex.ru"]
  s.homepage    = ""
  s.summary     = 'summary'
  s.description = 'description'

  s.rubyforge_project = "chatbot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "jabber-bot"
end
