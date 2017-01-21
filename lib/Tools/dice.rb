class Dice

  attr_accessor :roll

  def initialize()
    @roll = 0
  end

  def roll2
    @roll =  2 + rand(6) + rand(6)
  end

  def roll1
    @roll = 1 + rand(6)
  end

  def average1
    @roll = ((rand(6) + rand(6) + rand(6)) / 3) + 1
  end

  def average2
    @roll = ((rand(6) + rand(6) + rand(6) + rand(6) + rand(6) + rand(6)) / 3) + 2
  end

end

