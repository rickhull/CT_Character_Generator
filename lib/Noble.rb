# Class for the Nobility. Takes a character and optional number of terms.

require 'CharacterTools'
require 'Traveller'

class Noble 
    @skill_options = [ 
      '+1 Str',
      '+1 Dex',
      '+1 End', 
      '+1 Int', 
      'Carouse', 
      'Brawling', 
      'GunCbt', 
      'Blade', 
      'Hunting', 
      'Drive(any)',
      'Bribery', 
      '+1 Dex',
      'Pilot', 
      'ShipsBoat', 
      'Drive(any)', 
      'Navigation', 
      'Engineering', 
      'Leader'
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

  def self.set_rank(character)
    terms = (character.age - 18) / 4
    promotion_roll_required = 12 - terms
    promotion_level = Traveller.roll_dice(6,2) / 3
    CharacterTools.modify_stat(character, "Soc", promotion_level) if promotion_level > 0 
  end

  def self.run_career(character, terms)
    self.set_rank(character)
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

