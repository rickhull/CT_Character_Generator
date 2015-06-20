$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class Marine < Character
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
    'E8' => 'Gunnery Sergeant',
    'E9' => 'Sergeant Major',
    'O1' => 'Lieutenant',
    'O2' => 'Captain',
    'O3' => 'Force Commander',
    'O4' => 'Lieutenant Colonel',
    'O5' => 'Colonel',
    'O6' => 'Brigadier'
  }

  attr_accessor :rank

  def initialize()
    super
    @career = 'Marine'
    @comission_roll = 9
    @grade_set = 'Enlisted'
    @officer = officer(@comission_roll)
    @rank = 'Private'
    @skills = { 'Blade' => 1 , 'GunCbt' => 1 }
    @skill_options = [ 'Brawling', 'Gambling', '+1 Str', '+1 Dex', '+1 End', 'GunCbt', 'Blade', 'VaccSuit', 'GunCbt', 'Driver']
    @advanced_skill_options = ['Medical', 'Computer', 'Sensors', 'Leadership']
    @officer_skill_options = ['+1 Edu', '+1 Soc', 'Vehicle', 'HvyWpns', 'Leadership', 'Tactics', 'Mechanic', 'FwdObs', 'Computer', 'Electroncs', 'Medical', 'Instruction', 'Admin']
  end

  def set_rank()
    if @officer 
      grade_set = 'Officer'
      grade_level = [terms, 5].min
      min_stat('Edu', 6)
    else
      grade_set = 'Enlisted'
      grade_level = [terms + 1, 8].min
    end 
    grade = Grade[grade_set][grade_level]
    @rank = Ranks[grade]
  end

  def set_skills()
    edu = upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end

    if @officer
      @skill_options = @skill_options + @officer_skill_options
    end

    rolls = terms + 1 
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
  end

end

