require 'character'

class Mountainman < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'Mountain Man'
    @rank = ''
    @skills = { 'Survival' => 1 }
    @skill_options = [ 'Brawling', 'Survival', 'Hunting', 'Gambling', 'Vehicle', '+1 Int', 'GunCbt', 'Blade', 'Mechanical', 'JoT' ]
    @advanced_skill_options = ['+1 Edu', 'Medical', 'Vehicle', 'Leader']
    @morale = morale
  end

  def set_rank()
    @rank = ''
  end

  def set_skills()
    max_stat('Soc', 4)
    edu = upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end

    rolls = terms + 1 
    @morale += rolls + 2
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
  end

  
end

