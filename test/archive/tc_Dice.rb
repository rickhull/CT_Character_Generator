$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "Dice"

class TestDice < Test::Unit::TestCase

  def test_roll_one_die
    @die = Dice.roll_dice(6,1,1)
    assert(@die <= 6)
    assert(@die => 1)
    assert_kind_of(Integer, @die)
  end

  def test_roll_two_dice
    @dice = Dice.roll_dice(6,2,1)
    assert(@dice <=12)
    assert(@dice >= 2)
    assert_kind_of(Integer, @dice)
  end
end
