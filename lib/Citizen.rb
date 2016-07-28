# Class for the regular citizens. Takes a character, and 
# optional number of terms.

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
  
  def initialize(char)
    @character          = char['character']
    @career             = char['career']
  end

  def self.first_term(character, skill_options)
    character.rank     = ""
    2.times do
      new_skill = skill_options[rand(skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end
  end

  def self.run_career(character, terms)
    edu = character.upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end
    first_term(character, @skill_options)
    terms -= 1
    0.upto(terms) do
      new_skill = @skill_options[rand(@skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end 
  end

end

