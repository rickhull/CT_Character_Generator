require "CharacterTools"
require "Career"
require "Traveller"

class Other < Career
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 Edu", 
      "-1 Soc", 
      "Brawling", 
      "Blade", 
      "Vehicle",
      "Gambling", 
      "Brawling", 
      "Bribery", 
      "Blade", 
      "GunCbt", 
      "Streetwise", 
      "Mechanical", 
      "Electronic", 
      "Gambling", 
      "Brawling", 
      "Forgery" 
      ]
    @advanced_skill_options = [
      "Medic",
      "Computer",
      "Forgery",
      "Electronic", 
      "Liaison",
      "Streetwise", 
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 10000, 10000, 10000, 50000, 100000]
    @muster_out["benefits"] = [
      "LowPsg",
      "+1 Int",
      "+1 Edu",
      "Gun",
      "HighPsg"
    ]
    super(char)
  end
 
  def rank(char)
    char["character"].rank     = nil
  end

end
