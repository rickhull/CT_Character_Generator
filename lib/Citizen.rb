# Class for the regular citizens. Takes a character, and optional number of terms.

require "CharacterTools"
require "Traveller"
require "Career"

class Citizen < Career
  
  def initialize(char)
  @skill_options = [ 
    "+1 Str",
    "+1 Dex",
    "+1 Edu", 
    "+1 Int", 
    "Carouse", 
    "Brawling", 
    "Mechanical",
    "Vehicle",  
    "Streetwise",
    "Bribery",
    "Gambling",
    "Blade",
    "Steward",
    "Electronics",
    "Medical",
    "Computer",
    "Admin",
    "+1 Soc"
    ]
  @advanced_skill_options = [
    "Medic",
    "Computer",
    "Admin",
    "Liaison",
    "Leader",
    "Electronics",
    "JoT"
    ]

  @muster_out = Hash.new
  @muster_out["cash"] = [ 1000, 3000, 5000, 7000, 9000 ]
  @muster_out["benefits"] = [
    "Low Passage",
    "Blade",
    "+1 Int",
    "+2 Edu",
    "Gun",
    "Middle Passage"
    ]
  super(char)
  end

  # Set rank to nil so it and the space aren't printed.
  def rank(char)
    char["character"].rank = nil    
  end
end
