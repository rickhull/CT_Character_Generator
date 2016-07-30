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

  @muster_out = Hash.new
  @muster_out['cash'] = [ 1000, 3000, 5000, 7000, 9000 ]
  @muster_out['benefits'] = [
    'Low Passage',
    'Blade',
    'Gun',
    'Middle Passage'
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

  def self.muster_out(character)
    career = "Citizen"
    terms = character.careers[career]
    terms.times do |roll|
      character.stuff['cash'] += @muster_out['cash'][rand(@muster_out['cash'].length)]
    end
    terms.times do |term|
      benefit = @muster_out['benefits'][rand(@muster_out['benefits'].length)]
      if character.stuff['benefits'].has_key?(benefit)
        character.stuff['benefits'][benefit]  += 1
      else
        character.stuff['benefits'][benefit]  = 1 
      end
    end
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
