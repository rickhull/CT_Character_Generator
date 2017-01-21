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

class LEO < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Athletics",
      "Blade", 
      "Brawling", 
      "Bribery", 
      "Carouse", 
      "Deception",
      "GunCbt", 
      "Intrusion",
      "Leader",
      "Persuade",
      "Recon",
      "Stealth",
      "Streetwise",
      "Vehicle"
      ]
    @advanced_skill_options = [
      "Admin",
      "Computer",
      "Electronics",
      "Interrogation",
      "Investigate",
      "Legal",
      "Liaison",
      "Science(Forensic)",
      "Tactics"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 5000, 10000, 10000, 10000, 20000]
    @muster_out["benefits"] = [
      "LowPsg",
      "MedPsg",
      "Gun",
    ] 
    super(char) 
  end

  def first_term(char)
    career_skill_list     = ["Admin", "Carouse", "Computer", "GunCbt", "Investigate", "Streetwise", "Science(Forensic)"]
    career_skill          = career_skill_list[rand(career_skill_list.length - 1)]
    options               = Hash.new(0)
    options["character"]  = char["character"]
    options["level"]      = 1
    options["skill"]      = career_skill
    CharacterTools.increase_skill(options)
  end

  def rank(char)
    ranks = %w[Recruit Officer Patrol Sergeant Lieutenant Captain Chief]
    char["character"].rank = ranks[char["terms"]]
  end
end
