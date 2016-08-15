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

class Marine < Career 
  def initialize(char)
    @skill_options = [ 
      "Brawling", 
      "Gambling", 
      "+1 Str", 
      "+1 Dex", 
      "+1 End", 
      "Blade", 
      "Vehicle", 
      "VaccSuit", 
      "Blade", 
      "GunCbt", 
      "GunCbt", 
      "GunCbt", 
      "Vehicle", 
      "Mechanical", 
      "Electronic", 
      "Tactics", 
      "Blade" 
      ]
    @advanced_skill_options = [
      "Medical", 
      "Tactics", 
      "Tactics",  
      "Computer", 
      "Admin", 
      "Leader"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [2000, 5000, 5000, 10000, 20000, 30000, 40000]
    @muster_out["benefits"] = [
      "LowPsg",
      "+2 Int",
      "+1 Edu",
      "Blade",
      "TAS",
      "HighPsg",
      "+2 Soc"
    ] 
    super(char) 
  end
  
  def first_term(char)
    CharacterTools.increase_skill(char["character"], "Blade", 1)
    CharacterTools.increase_skill(char["character"], "GunCbt", 1)
  end
  
  def rank(char)
    officers = %w[ LT CPT FC LTC COL BG ]
    enlisted = %w[ PVT LCP CPL LSGT SGT LDSG 1SGT GSGT SMSG ]
    commission   = 9
    commission_roll  = Traveller.roll_dice(6,2,1) + char['terms'] - commission
    if commission_roll >= 0
      char['character'].rank = officers[commission_roll/2]
    else
      char['character'].rank = enlisted[char['terms'] + rand(2)]
    end
  end

end
