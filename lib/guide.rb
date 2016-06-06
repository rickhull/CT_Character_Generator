require 'character'

class Guide < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'Guide'
    @rank = ''
    @skills = { 'CbtR' => 1 }
    @skill_options = [ 'Vehicle', 'JoT', 'Leader', '+1 Dex', 'Hunting', 'Survival', '+1 Edu', '+1 End', '+1 Int', 'Persuade', 'GunCbt', 'Computer', 'Art(any)', 'Trade(any)', 'Recon' ]
    @advanced_skill_options = ['Advocate', 'Science(any)', 'Streetwise', 'Liason', '+1 Soc']
  end

  def set_rank()
    @rank = ''
  end

  def set_skills()
    edu = upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end

    rolls = terms + 1
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
    @title = Traveller.noble(@gender, @upp)
  end

end
