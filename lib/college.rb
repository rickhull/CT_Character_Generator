require 'character'

class College < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'College Student'
    @skills = { 'Computer' => 1 }
    @skill_options = [ 'Administration', 'Electronic', 'Athletics', '+1 Int', '+1 Edu', 'Vehicle' ]
    @advanced_skill_options = ['+1 Edu', 'Science', 'Computer', 'Engineering', 'Medical', 'Leader']
  end

  def set_rank()
    @rank = 'Undergrad'
  end

  def set_skills()
    edu = upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    else 
      increase_stat('Edu', '2')
    end

    min_stat('Soc', 6)

    @terms = 0
    @age = 18 + rand(3)

    rolls = 1 
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
    @title = Traveller.noble?(@gender, @upp)
  end

end

