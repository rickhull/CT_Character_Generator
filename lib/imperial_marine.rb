$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class ImperialMarine < Character
  Grade = Hash.new
  Grade['Enlisted'] = %w(E1 E2 E3 E4 E5 E6 E7 E8 E9)
  Grade['Officer'] = %w(O1 O2 O3 O4 O5 O6)

  Ranks = { 
    'E1' => 'Private',
    'E2' => 'Lance Corporal',
    'E3' => 'Corporal',
    'E4' => 'Lance Sergeant',
    'E5' => 'Sergeant',
    'E6' => 'Leading Sergeant',
    'E7' => 'First Sergeant',
    'E8' => 'Sergeant Major',
    'O1' => 'Lieutenant',
    'O2' => 'Captain',
    'O3' => 'Force Commander',
    'O4' => 'Lieutenant Colonel',
    'O5' => 'Colonel',
    'O6' => 'Brigadier'
  }

  Comission_roll = 9

  def initialize()
    super
    @career = 'Marine'
    @rank = 'Private'
    @skills = { 'Blade' => 1 }
  end

  def set_rank()
    roll = roll2
    if roll >= Comission_roll
      grade_set = 'Officer'
      grade_level = [terms, 5].min
    else
      grade_set = 'Enlisted'
      grade_level = [terms + 2, 8].min
    end 
    grade = Grade[grade_set][grade_level]
    @rank = Ranks[grade]
  end

end

