module Marine
  def show_rank
    puts "I am a Marine!"
  end
end

module Pirate
  def show_rank
    puts "Arrgghhh!!"
  end
end

class Character
  include Marine
  include Pirate

  def set_career(career)
    @career = career
    #puts career:show_rank()
  end
end

Fred = Character.new
Fred.set_career(Marine)
Fred.show_rank

