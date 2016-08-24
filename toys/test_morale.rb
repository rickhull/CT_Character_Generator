$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"

morale = CharacterTools.morale
puts morale

fred = CharacterTools.init
options = Hash.new(0)
options["character"] = fred
options["terms"]      = 50
options["career"]     = "Marine"
CharacterTools.add_career(options)
require "Marine"
Marine.new(fred)
fred_morale = CharacterTools.morale(options)
puts fred_morale
