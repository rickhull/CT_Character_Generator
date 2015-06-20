$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class Navy < Character
  Grade = Hash.new
  Grade['Enlisted'] = %w(E1 E2 E3 E4 E5 E6 E7 E8 E9)
  Grade['Officer'] = %w(O1 O2 O3 O4 O5 O6)

  Ranks = { 
    'E1' => 'Spacehand Recruit',
    'E2' => 'Spacehand Apprentice',
    'E3' => 'Able Spacehand',
    'E4' => 'Petty Officer Third Class',
    'E5' => 'Petty Officer Second Class',
    'E6' => 'Petty Officer First Class',
    'E7' => 'Chief Petty Officer',
    'E8' => 'Senior Chief Petty Officer',
    'E9' => 'Master Chief Petty Officer',
    'O1' => 'Ensign',
    'O2' => 'Sublieutenant',
    'O3' => 'Lieutenant',
    'O4' => 'Lieutenant Commander',
    'O5' => 'Commander',
    'O6' => 'Admiral'
  }

  attr_accessor :rank

  def initialize()
    super
    @career = 'Navy'
    @comission_roll = 6
    @grade_set = 'Enlisted'
    @officer = officer(@comission_roll)
    @rank = 'Spacehand Recruit'
    @skills = { }
    @basic_skill_options = [ 'Eng', 'Navg', 'VaccSuit', 'ZeroG', 'Mechanical']
    @advanced_skill_options = ['Medic', 'Computer', 'Pilot', 'Sensors', 'Leadership']
    @officer_skill_options = ['Medic', 'Computer', 'Leadership', 'Admin', '+1 Soc']
  end

  def set_rank()
    if @officer 
      grade_set = 'Officer'
      grade_level = [terms, 5].min
      min_stat('Edu', 6)
    else
      grade_set = 'Enlisted'
      grade_level = [terms + 2, 8].min
    end 
    grade = Grade[grade_set][grade_level]
    @rank = Ranks[grade]
  end

  def set_skills()
    edu = upp[4].chr.to_i(16)
    if edu >= 8
      skill_options = @basic_skill_options + @advanced_skill_options
    else
      skill_options = @basic_skill_options
    end

    if @officer
      skill_options = skill_options + @officer_skill_options
    end

    rolls = terms + 1 
    rolls.times do
      new_skill = skill_options[rand(skill_options.count)]
      increase_skill(new_skill)
    end
  end

end

