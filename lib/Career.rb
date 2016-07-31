# Class for careers. Should be subclassed by the specific careers.

require 'CharacterTools'
require 'Traveller'

class Career
  @skill_options = Hash.new(0)
  @advanced_skill_options = Hash.new(0)

  @muster_out = Hash.new
  @muster_out['cash'] = Array.new
  @muster_out['benefits'] = Array.new
  
  # Setting default skill points.
  @skill_points = 2 

  # Initial term. Some careers half default skills.
  def self.first_term(character)
  end

  # Set rank 
  def self.rank(character)
  end

  def self.muster_out(character, career, muster_out)
    terms = character.careers[career]
    puts character.careers[career]
    until terms < 1 do
      terms -= 2
      character.stuff['cash'] += muster_out['cash'][rand(muster_out['cash'].length)]
      benefit = muster_out['benefits'][rand(muster_out['benefits'].length)]
      if character.stuff['benefits'].has_key?(benefit)
        character.stuff['benefits'][benefit]  += 1
      else
        character.stuff['benefits'][benefit]  = 1 
      end
    end
    pp character
    pp muster_out
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

    muster_out(character)

    # Some careers can raise Soc, so do this after skills.
    CharacterTools.title(character)
  end
end
