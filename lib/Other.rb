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

  def self.run_career(character)
    terms = character.careers['Other']
    edu = character.upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end
    first_term(character, @skill_options)
    0.upto(terms) do
      new_skill = @skill_options[rand(@skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end 
  end
end
