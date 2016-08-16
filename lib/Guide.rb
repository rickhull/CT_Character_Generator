# Template for new Careers. To create your own Career:

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

class Guide < Career 
  def initialize(char)
    @skill_options = [ 
      "+1 Str",
      "+1 Dex",
      "+1 End", 
      "+1 Int", 
      "Blade", 
      "Carouse", 
      "Brawling", 
      "GunCbt", 
      "GunCbt", 
      "GunCbt", 
      "Blade", 
      "Blade", 
      "Blade", 
      "Vehicle",
      "Bribery", 
      "Vehicle",
      "JoT",
      "Hunting",
      "Survival",
      "Persuade",
      "Computer",
      "Art(any)",
      "Trade(any)",
      "Recon",
      "Leader"
      ]
    @advanced_skill_options = [
      "Medic",
      "Advocate",
      "Science(any)",
      "Streetwise",
      "Liaison",
      "+1 Soc",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [1000, 5000, 5000, 10000, 10000, 10000, 20000]
    @muster_out["benefits"] = [
      "Gun",
      "Blade",
      "+2 Int",
      "+2 Edu",
      "+1 Soc"
    ] 
    super(char) 
  end

  def first_term(char)
    CharacterTools.increase_skill(char["character"], "Blade", 1)
    CharacterTools.increase_skill(char["character"], "GunCbt", 1)
  end

  def rank(char)
    char["character"].rank = nil
  end

end
