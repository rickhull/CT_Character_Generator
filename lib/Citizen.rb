# Class for the regular citizens. Takes a character, and optional number of terms.

require 'CharacterTools'
require 'Traveller'

class Citizen 
    @skill_options = [ '+1 Str',
      '+1 Dex',
      '+1 Edu', 
      '+1 Int', 
      'Carouse', 
      'Brawling', 
      'GunCbt', 
      'Blade', 
      'Hunting', 
      '+1 Dex',
      'Bribery', 
      'Drive(any)', 
      'Pilot', 
      'ShipsBoat', 
      'Drive(any)', 
      'Navigation', 
      'Engineering', 
      'Leader',
      'Athletics'
      ]
    @advanced_skill_options = [
      'Medic',
      'Computer',
      'Admin',
      'Liaison',
      'Leader',
      'JoT'
      ]

  # Setting default skill points.
  @skill_points = 2 

  # Initial set up. For Citizens there's no default skill. 
  def self.first_term(character)
  end

  # Set rank to nil so it and the space aren't printed.
  def self.rank(character)
    character.rank = nil    
  end

  # The generic run_career method. 
  def self.run_career(char)
    character          = char['character']
    career             = char['career']
    terms = character.careers[career]
    edu = character.upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end
    rank(character)
    first_term(character)
    # Keep @skill_points late as rank can add to it.
    @skill_points += terms
    @skill_points -= 1
    0.upto(@skill_points) do
      new_skill = @skill_options[rand(@skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end 
    # Some careers can raise Soc, so do this after skills.
    CharacterTools.title(character)
  end
end
