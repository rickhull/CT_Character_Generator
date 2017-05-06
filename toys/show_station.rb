$LOAD_PATH << File.expand_path("../../lib/Careers", __FILE__)
$LOAD_PATH << File.expand_path("../../lib/Tools", __FILE__)

require "Character"

fred = Character.new
fred.generate
fred.upp = "77777F"
fred.to_s
