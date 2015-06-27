$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class Warder < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'North Warder'
    @rank = ''
    @skills = { 'Streetwise' => 1 }
    @skill_options = [ 'Brawling', 'Bribery', 'Forgery', 'Gambling', '+1 Dex', '+1 Int', 'GunCbt', 'Blade', 'Mechanical', 'JoT' ]
    @advanced_skill_options = ['Computer', 'Electronic', 'Medical', 'Vehicle', 'Steward', 'Leader']
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
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
  end

  
end

