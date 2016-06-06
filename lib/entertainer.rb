require 'character'

class Entertainer < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'Entertainer'
    @rank = ''
    @skills = { 'Art(any)' => 1 }
    @skill_options = [ 'Art(any)', 'Carouse', 'Deception', '+1 Dex', '+1 Soc', '+1 Int', 'Persuade', 'Steward', 'Computer', 'Gambler', 'Trade(any)', 'Comms', 'Art(any)', 'Streetwise', 'Athletics' ]
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

