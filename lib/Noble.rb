# Class for the Nobility. Takes a character and optional number of terms.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"
require "Career"
require "Traveller"

class Noble < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Carouse", 
      "Brawling", 
      "GunCbt", 
      "Blade", 
      "Hunting", 
      "Drive(any)",
      "Bribery", 
      "+1 Dex",
      "Pilot", 
      "ShipsBoat", 
      "Drive(any)", 
      "Navigation", 
      "Engineering", 
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Computer",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
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
      CharacterTools.modify_stat(char["character"], "Soc", promotion_level) 
      char["skill_points"] += promotion_level
    end
  end

end
