$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "Character"
require "CharacterTools"

fred = Character.new
fred.name = "Frederick the First"
puts fred.name
puts fred.name.length

options = Hash.new(0)
options["character"] = fred

CharacterTools.modify_stat(options)
