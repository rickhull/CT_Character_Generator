# Class for the Nobility based on Robert Weaver's article. 
# The skill choices are used by permission from 
# http://ancientfarfuture.blogspot.com/2014/05/lords-of-imperium-revisiting-noble.html
# Thanks Robert!

require "tools/character_tools"
require "tools/career"
require "tools/dice"

class Noble < Career 
  @skill_options = [ 
    "+1 Int", 
    "+1 Edu", 
    "Carousing", 
    "JoT",
    "Leader",
    "Brawling",
    "Hunting",
    "Pilot",
    "Leader",
    "GunCbt",
    "Vehicle",
    "Medical",
    "Leader",
    "Admin",
    "Carousing",
    "Liaison",
    "Bribery",
    "Gabmling"
    ]
  @advanced_skill_options = [
    "Leader",
    "Admin",
    "Liaison",
    "Bribery",
    "JoT",
    "Computer"
    ]

  @muster_out_benefits = Hash.new
  @muster_out_benefits["cash"] = [10000, 200000]
  @muster_out_benefits["benefits"] = [
    "HighPsg",
    "HighPsg",
    "Gun",
    "Blade",
    "TAS",
    "Yacht"
  ] 
end

def rank(character)
  terms = character.careers["Noble"]
  promotion_roll_required = 10 - terms
  promotion_level = (Dice.roll_dice(6,2) - promotion_roll_required) / 3
  if promotion_level > 0 
    options               = Hash.new
    options["character"]  = character
    if character.noble?
      options["stat_level"] = promotion_level
      options["stat"]       = "Soc"
      options["skill"]      = @advanced_skill_options.sample
      CharacterTools.modify_stat(options) 
    else
      character.upp[5] = "B"
      options["skill"]      = @skill_options.sample
    end
    CharacterTools.increase_skill(options) 
  end
end
