require 'rubygems'

Gem::Specification.new do |s|
  s.name          = "CT_Character_Generator".freeze
  s.version       = "1.0.2"
  s.authors       = ["Leam Hall"]
  s.executables   = ["Chargen"]
  s.platform      = Gem::Platform::RUBY
  s.description   = "Generates Classic Traveller Characters."
  s.summary       = "Classic Traveller Characters."
  s.files         = Dir.glob("{bin,docs,lib,test,data}/**/*")
  s.test_file     = "test/ts_CT_Character_Generator.rb"
  s.has_rdoc      = false
  s.require_paths = ["lib/Tools", "lib/Careers"]
end
