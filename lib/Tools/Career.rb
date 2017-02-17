include CharacterTools

class Career
  
  def initialize(char)
    run_career(char)
  end

  # Initial term. Some careers have default skills.
  def first_term(char)
  end

  # Set rank 
  def rank(char)
  end

  def muster_out(char)
    career      = char["career"]
    character   = char["character"]
    muster_out  = char["muster_out"]
    terms       = character.careers[career]
    skill_stuff = ["Gun", "Blade", "Weapon"]
    until terms < 1 do
      terms -= 2
      cash_length     = muster_out["cash"].length - 1
      benefits_length = muster_out["benefits"].length - 1
      character.stuff["cash"] += muster_out["cash"][rand(cash_length)]
      benefit = muster_out["benefits"][rand(benefits_length)]
      if benefit.match(/\+/)
        options               = Hash.new(0)
        options["character"]  = character
        options["level"]      = benefit.split[0].to_i
        options["stat"]       = benefit.split[1]
        CharacterTools.modify_stat(options)
      elsif skill_stuff.include?(benefit) && character.stuff["benefits"].has_key?(benefit)
        options               = Hash.new(0)
        case benefit
          when "Gun" 
            options["character"]  = character
            options["skill"]      = "GunCbt"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
          when "Blade"
            options["character"]  = character
            options["skill"]      = "Blade"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
          when "Weapon"
            options["character"]  = character
            options["skill"]      = "Weapon"
            options["level"]      = 1
            CharacterTools.increase_skill(options)
        end 
      elsif character.stuff["benefits"].has_key?(benefit)
        character.stuff["benefits"][benefit]  += 1
      else
        character.stuff["benefits"][benefit]  = 1 
      end
    end
  end

  def run_career(char)
    character               = char["character"]
    career                  = char["career"]
    terms                   = char["terms"] 
    char["skill_points"]    = terms
    char["skill_options"]   = Array.new

    if character.upp[4].chr.to_i(16) >= 8
      char["skill_options"] = @skill_options + @advanced_skill_options
    else
      char["skill_options"] = @skill_options
    end
    char["muster_out"]      = @muster_out
    
    rank(char)
    first_term(char)
    # Keep @skill_points late as rank can add to it.
    skill_points          = char["skill_points"]
    skill_options         = char["skill_options"] 
    options               = Hash.new(0)
    options["character"]  = character
    0.upto(skill_points) do
      new_skill = skill_options[rand(skill_options.count)]
      options["skill"]      = new_skill
      options["level"]      = 1
      CharacterTools.increase_skill(options)
    end 
    muster_out(char)

  end
end
