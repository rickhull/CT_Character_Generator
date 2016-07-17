$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'test/unit'
require 'Traveller'

class TestTraveller < Test::Unit::TestCase

  def test_roll_one_die
    @die = Traveller.roll_dice(6,1,1)
    assert(@die <= 6)
    assert(@die => 1)
    assert_instance_of(Fixnum, @die)
  end

  def test_roll_two_dice
    @dice = Traveller.roll_dice(6,2,1)
    assert(@dice <=12)
    assert(@dice >= 2)
    assert_instance_of(Fixnum, @dice)
  end

  def test_upp
    @upp = Traveller.upp
    assert(@upp.length == 6)
    assert(/[:xdigit:]{6}/, @upp)
    assert_instance_of(String, @upp)
    (0..5).each do |num|
      assert(@upp[num].chr.to_i(16) <= 15)
      assert(@upp[num].chr.to_i(16) >= 2)
    end
  end

  def test_gender
    genders = ['female', 'male']
    200.times do |count|
      assert(genders.include?(Traveller.gender))
    end
  end

  def test_modify_stat
    upp = "777777"
    assert(Traveller.modify_stat(upp,0,+8) == "F77777")
    upp = "777777"
    assert(Traveller.modify_stat(upp,0,+9) == "F77777")
    upp = "777777"
    assert(Traveller.modify_stat(upp,0,-9) == "077777")
  end

  def test_set_stat
    upp = "777777"
    assert(Traveller.set_stat(upp,0,"F") == "F77777")
  end

  def test_noble?
    upp = "77777F"
    assert(Traveller.noble?(upp))
  end


end
