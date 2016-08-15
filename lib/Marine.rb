module Marine

  self.grade = "E1"

  self.Ranks = { 
    "E1" => "Private",
    "E2" => "Lance Corporal",
    "E3" => "Corporal",
    "E4" => "Lance Sergeant",
    "E5" => "Sergeant",
    "E6" => "Leading Sergeant",
    "E7" => "First Sergeant",
    "E8" => "Gunnery Sergeant",
    "E9" => "Sergeant Major",
    "O1" => "Lieutenant",
    "O2" => "Captain",
    "O3" => "Force Commander",
    "O4" => "Lieutenant Colonel",
    "O5" => "Colonel",
    "O6" => "Brigadier"
  }

    comission_roll = 9
    skill_options = [ 
      "Brawling", 
      "Gambling", 
      "+1 Str", 
      "+1 Dex", 
      "+1 End", 
      "Blade", 
      "Vehicle", 
      "VaccSuit", 
      "Blade", 
      "GunCbt", 
      "GunCbt", 
      "Vehicle", 
      "Mechanical", 
      "Electronic", 
      "Tactics", 
      "Blade", 
      "GunCbt"
      ]
    
    advanced_skill_options = [
      "Medical", 
      "Tactics", 
      "Tactics",  
      "Computer", 
      "Admin", 
      "Leader"
      ]

  def Marine.first_term(character)
    Traveller.add_skill(character.skills, "Blade", 1)
    Traveller.add_skill(character.skills, "GunCbt", 1)
  end
  
  def self.set_skills(character, terms)
    rolls = terms + 1 
    new_skill = @skill_options[rand(@skill_options.count)]
    increase_skill(new_skill)
    end
end
