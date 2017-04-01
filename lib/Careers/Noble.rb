# Class for the Nobility based on Robert Weaver's article. 
# The skill choices are used by permission from 
# http://ancientfarfuture.blogspot.com/2014/05/lords-of-imperium-revisiting-noble.html
# Thanks Robert!

require "CharacterTools"
require "Career"
require "Dice"

class Noble < Career 
  def initialize
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
      "+1 Soc",
      "TAS",
      "Yacht"
    ] 
  end

  def rank(character)
    options               = Hash.new
    options["character"]  = character
    options["minimum"]    = "A"
    options["index"]      = 3
    options["modifier"]   = 2
    promotion_modifier = CharacterTools.stat_modifier(options)
    
    terms = character.careers["Noble"]
    promotion_roll_required = 12 - terms
    promotion_level = (Dice.roll_dice(6,2) - promotion_roll_required) / 3
  
    if promotion_level > 0 
      options["level"]      = promotion_level
      options["stat"]       = "Soc"
      CharacterTools.modify_stat(options) 
      character["skill_points"] += promotion_level
    end
  end

end
