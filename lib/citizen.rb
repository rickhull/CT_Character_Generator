require 'character'

class Citizen < Character
  
  attr_accessor :rank

  def initialize()
    super
    @career = 'Citizen'
    @rank = ''
    #@skills = { 'Art(any)' => 1 }
    @skill_options = [ '+1 Edu', '+1 Int', 'Carouse', 'Drive(any)', 'JoT', 'Flyer(any)', 'Streetwise', 'Steward', 'Computer', 'Gambler', 'Trade(any)', 'Comms', 'Advocate', 'Admin', 'Broker', 'Survival', 'Engineering', 'Streetwise', 'Athletics' ]
    @advanced_skill_options = ['Advocate', 'Diplomat', 'Science(any)', 'Medic', 'Language', 'Computer']
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
    @title = Traveller.noble?(@gender, @upp)
  end

end

