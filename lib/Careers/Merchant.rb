# Template for new Careers. To create your own Career:

# 1. Change Mycareer to your career name. One word, and Ruby 
#     classes must begin with an uppercase Alpha character.
#
# 2. Change the skill_options array to use the list of skills
#     that don"t require Edu 8+. Look at existing skill lists
#     for the format. 
#    You can duplicate entries if a career should have a higher
#     instance of some skill. 
#
# 3. Change advanced_skill_options for skills requiring an Edu 8+
#     to get in CharGen.
#
# 4. Change values in muster_out["cash"] array.
#
# 5. Change values in muster_out["benefits"] array.
#
# 6. Change the rank method if the career has ranks. 
#     Add a commission roll as needed.
#     Add the names of the ranks. 
#     Recommended, but not required, to use terms as roll modifier.
#
# 7. Add the following stanza to the case statement in Chargen.rb:
#     when "Mycareer" then
#       require "Mycareer"
#       Mycareer.new(char)
#
# 8. Add "Mycareer" to the "available_careers" array in Chargen.rb.
#

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"
require "Career"
require "Traveller"

class Merchant < Career 
  def initialize(char)
    @skill_options = [ 
      "Carouse", 
      "Brawling", 
      "Brawling", 
      "Vehicle",
      "Vehicle",
      "Gambling",
      "Gambling",
      "Trader",
      "Trader",
      "Blade", 
      "VaccSuit",
      "ZeroG",
      "Commo",
      "GunCbt", 
      "Liaison",
      "Liaison",
      "Admin",
      "Admin",
      "Admin",
      "Computer",
      "Bribery",
      "Streetwise",
      "Navigation",
      "Navigation",
      "Pilot",
      "Pilot",
      "Leader",
      "Leader",
      "Mechanical",
      "Electronic",
      "Engineering",
      "Admin",
      "Admin",
      "Admin",
      "Admin",
      "Engineering",
      "Gravitics",
      "Steward",
      "Medical",
      "Liaison",
      "Liaison",
      "Gunnery",
      "Steward",
      "Liaison",
      "Steward",
      "Medical",
      "Medical",
      "Medical",
      "Medical",
      "Computer",
      "Computer",
      "Trader",
      "Trader",
      "Bribery",
      "Legal",
      "Legal",
      "Liaison",
      "Liaison",
      "Streetwise",
      "Broker",
      "Broker",
      "GunCbt",
      "GunCbt",
      "Streetwise",
      "Streetwise",
      "Forgery",
      "Bribery",
      "Legal",
      "Steward",
      "Trader",
      "Broker",
      "Admin",
      "Gunnery",
      "Leader",
      "Engineering",
      "Navigation",
      "Steward",
      "Legal",
      "Steward",
      "Broker", 
      "VaccSuit",
      "VaccSuit",
      "Brawling",
      "Brawling",
      "+1 Dex",
      "Broker",
      "JoT",
      "+1 Edu",
      "+1 Str",
      "+1 End", 
      "+1 Int", 
      "Vehicle",
      "Bribery", 
      "Pilot", 
      "ShipsBoat", 
      "Engineering", 
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Bribery", 
      "Pilot", 
      "Pilot", 
      "Pilot", 
      "Pilot", 
      "ShipsBoat", 
      "Engineering", 
      "Pilot", 
      "Pilot", 
      "Computer",
      "Admin",
      "Pilot", 
      "Pilot", 
      "Liaison",
      "Pilot", 
      "Pilot", 
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 10000, 20000, 20000, 40000, 50000, 100000]
    @muster_out["benefits"] = [
      "+2 Int",
      "+2 Edu",
      "+1 End",
      "Gun",
      "TAS",
      "Blade",
      "LowPsg",
      "MidPsg",
      "FreeTrader"
    ] 
    super(char) 
  end

  def rank(char)
    ranks     = %w[ APP 4OF 3OF 2OF 1OF CPT SCP COM LCM ]
    terms     = char["terms"]
    max_rank  = ranks.length - 1
    grade     = [terms, max_rank].min
    char["character"].rank = ranks[grade]
  end
end
