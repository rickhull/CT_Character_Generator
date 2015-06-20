$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class College < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'College Student'
    @rank = ''
    @skills = { 'Computer' => 1 }
    @skill_options = [ 'Administration', 'Electronics', 'Athletics', '+1 Int', '+ Edu', 'Vehicle' ]
    @advanced_skill_options = ['+1 Edu', 'Science', 'Computer', 'Engineering', 'Medical', 'Leadership']
  end

  def set_rank()
    @rank = ''
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
  end

end

