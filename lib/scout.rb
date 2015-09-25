require 'character'

class Scout < Character

  attr_accessor :rank

  def initialize()
    super
    @career = 'Scout'
    @skills = { 'Pilot' => 1 } 
    @skill_options = [ '+1 Str', '+1 Dex', '+1 End', '+1 Int', '+1 Edu', 'GunCbt', 'Vehicle', 'VaccSuit', 'Mechanical', 'Navigation', 'Electronic', 'JoT', 'Vehicle', 'Mechanical', 'Electronic', 'JoT', 'Gunnery', 'Medical']
    @advanced_skill_options = ['Navigation', 'Engineering', 'Computer', 'JoT', 'Pilot', 'Medical']
  end

  def set_rank()
    @rank = 'Scout'
  end

  def set_skills()
    rolls = terms + 2 

    edu = upp[4].chr.to_i(16)
    if edu >= 8
      skill_options = @skill_options + @advanced_skill_options
    else
      skill_options = @skill_options
    end

    rolls.times do
      new_skill = skill_options[rand(skill_options.count)]
      increase_skill(new_skill)
    end
  end

end

