# Class for the other citizens. Takes a character, and 
# optional number of terms.

require 'CharacterTools'
require 'Traveller'

class Other 
    @skill_options = [ 
      '+1 Str',
      '+1 Dex',
      '+1 Edu', 
      '-1 Soc', 
      'Brawling', 
      'Blade', 
      'Drive(any)',
      'Gambling', 
      'Brawling', 
      'Bribery', 
      'Blade', 
      'GunCbt', 
      'Streetwise', 
      'Mechanical', 
      'Electronic', 
      'Gambling', 
      'Brawling', 
      'Forgery' 
      ]
    @advanced_skill_options = [
      'Medic',
      'Computer',
      'Forgery',
      'Electronic', 
      'Liaison',
      'Streetwise', 
      'JoT'
      ]

  @skill_points = 2
  
  def self.first_term(character)
  end
  
  def self.rank(character)
    character.rank     = nil
  end

  def self.run_career(char)
    character = char['character']
    career    = char['career']
    terms     = character.careers[career]
    edu       = character.upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end
    rank(character)
    first_term(character)
    # Keep @skill_points late as rank can add to it.
    @skill_points += terms
    0.upto(@skill_points) do
      new_skill = @skill_options[rand(@skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end 
    # Some careers can raise Soc, so do this after skills.
    CharacterTools.title(character)
  end
end
