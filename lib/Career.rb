# Class for careers. Should be subclassed by the specific careers.

require 'CharacterTools'
require 'Traveller'

class Career
  @skill_options = Hash.new(0)
  @advanced_skill_options = Hash.new(0)

  @muster_out = Hash.new
  @muster_out['cash'] = Array.new
  @muster_out['benefits'] = Array.new
  
  def initialize(char)
    run_career(char)
  end

  # Initial term. Some careers half default skills.
  def first_term(char)
  end

  # Set rank 
  def rank(char)
    raise NotImplementedError,
      "#{self} cannot respond to:"
  end

  def muster_out(char)
    career      = char['career']
    character   = char['character']
    muster_out  = char['muster_out']
    terms       = character.careers[career]
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
  end

  # The generic run_career method. 
  #def self.run_career(char)
  def run_career(char)
    character               = char['character']
    career                  = char['career']
    terms                   = char['terms'] 
    char['skill_points']    = 1 + terms
    char['skill_options']   = Array.new

    if char['character'].upp[4].chr.to_i(16) >= 8
      char['skill_options'] = @skill_options + @advanced_skill_options
    else
      char['skill_options'] = @skill_options
    end
    char['muster_out']      = @muster_out
    rank(char)
    first_term(char)

    # Keep @skill_points late as rank can add to it.
    skill_points      = char['skill_points']
    skill_options     = char['skill_options'] 
    0.upto(skill_points) do
      new_skill = skill_options[rand(skill_options.count)]
      CharacterTools.increase_skill(character, new_skill)
    end 

    muster_out(char)

    # Some careers can raise Soc, so do this after skills.
    CharacterTools.title(character)
  end
end
