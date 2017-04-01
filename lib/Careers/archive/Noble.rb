# Class for the Nobility based on Robert Weaver's article. 
# The skill choices are used by permission from 
# http://ancientfarfuture.blogspot.com/2014/05/lords-of-imperium-revisiting-noble.html
# Thanks Robert!

require "CharacterTools"
require "Career"
require "Traveller"

class Noble < Career 
  def initialize(char)
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

    @muster_out = Hash.new
    @muster_out["cash"] = [10000, 50000, 50000, 100000, 100000, 100000, 200000]
    @muster_out["benefits"] = [
      "HighPsg",
      "HighPsg",
      "Gun",
      "Blade",
      "TAS",
      "Yacht"
    ] 
    super(char) 
  end

  def rank(char)
    options = { 
      "character" => char["character"],
      "minimum"   => "A",
      "index"     => 3,
      "modifier"  => 2
      }
    promotion_modifier = CharacterTools.stat_modifier(options)
    terms = char["character"].careers["Noble"]
    promotion_roll_required = 12 - terms
    promotion_level = (Traveller.roll_dice(6,2) - promotion_roll_required) / 3
    if promotion_level > 0 
      options["level"]      = promotion_level
      options["stat"]       = "Soc"
      CharacterTools.modify_stat(options) 
      char["skill_points"] += promotion_level
    end
  end

end
