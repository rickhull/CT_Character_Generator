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
 
  @skill_points = 2
 
  def self.first_term(character)
  end

  def self.rank(character)
    options = { 
      'character' => character,
      'minimum'   => "A",
      'index'     => 3,
      'modifier'  => 2
      }
    promotion_modifier = CharacterTools.stat_modifier(options)
    terms = character.careers['Noble']
    promotion_roll_required = 12 - terms
    promotion_level = (Traveller.roll_dice(6,2) - promotion_roll_required) / 3
    if promotion_level > 0 
      CharacterTools.modify_stat(character, "Soc", promotion_level) 
      @skill_points += promotion_level
    end
  end

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
