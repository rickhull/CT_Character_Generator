module Marine

  self.grade = "E1"

  self.Ranks = { 
    'E1' => 'Private',
    'E2' => 'Lance Corporal',
    'E3' => 'Corporal',
    'E4' => 'Lance Sergeant',
    'E5' => 'Sergeant',
    'E6' => 'Leading Sergeant',
    'E7' => 'First Sergeant',
    'E8' => 'Gunnery Sergeant',
    'E9' => 'Sergeant Major',
    'O1' => 'Lieutenant',
    'O2' => 'Captain',
    'O3' => 'Force Commander',
    'O4' => 'Lieutenant Colonel',
    'O5' => 'Colonel',
    'O6' => 'Brigadier'
  }

    #careers << 'Marine'
    comission_roll = 9
    skill_options = [ 
      'Brawling', 
      'Gambling', 
      '+1 Str', 
      '+1 Dex', 
      '+1 End', 
      'Blade', 
      'Vehicle', 
      'VaccSuit', 
      'Blade', 
      'GunCbt', 
      'GunCbt', 
      'Vehicle', 
      'Mechanical', 
      'Electronic', 
      'Tactics', 
      'Blade', 
      'GunCbt'
      ]
    
    advanced_skill_options = [
      'Medical', 
      'Tactics', 
      'Tactics',  
      'Computer', 
      'Admin', 
      'Leader'
      ]

  def Marine.first_term(character)
    Traveller.add_skill(character.skills, 'Blade', 1)
    Traveller.add_skill(character.skills, 'GunCbt', 1)
  end
  
def self.set_skills(character, terms)
    rolls = terms + 1 

    #edu = upp[4].chr.to_i(16)
    #if edu >= 8
    #  @skill_options = @skill_options + @advanced_skill_options
    #end

    #if @officer
    #  increase_skill('GunCbt')
    #  rolls = rolls + 1
    #end

    #@morale += rolls + 1

    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
end
