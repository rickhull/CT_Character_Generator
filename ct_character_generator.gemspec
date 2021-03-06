require 'rubygems'

Gem::Specification.new do |s|
  s.name          = "CT_Character_Generator".freeze
  s.version       = "1.0.2"
  s.authors       = ["Leam Hall"]
  s.email         = "leamhall@gmail.com"
  s.homepage      = "https://github.com/LeamHall/CT_Character_Generator"
  s.executables   = ["Chargen"]
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Generates Pseudo Classic Traveller Characters."
  s.description   = "For NPCs. Does not fully follow chargen process."
  s.files         = Dir.glob("{bin,docs,lib,test,data}/**/*")
  s.test_file     = "test/ts_CT_Character_Generator.rb"
  s.has_rdoc      = false
  s.require_paths = ["lib/Tools", "lib/Careers"]
  s.add_dependency("sqlite3-ruby", ">= 0")
end
