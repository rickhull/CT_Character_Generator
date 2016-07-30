$LOAD_PATH << File.expand_path("../../lib", __FILE__)

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

  #def test_gender
  #  genders = ['female', 'male']
  #  200.times do |count|
  #    assert(genders.include?(Traveller.gender))
  #  end
  #end

  #def test_modify_stat
  #  upp = "777777"
  #  assert(Traveller.modify_stat(upp,0,+8) == "F77777")
  #  upp = "777777"
  #  assert(Traveller.modify_stat(upp,0,+9) == "F77777")
  #  upp = "777777"
  #  assert(Traveller.modify_stat(upp,0,-9) == "077777")
  #end

  #def test_set_stat
  #  upp = "777777"
  #  assert(Traveller.set_stat(upp,0,"F") == "F77777")
  #end

  #def test_noble?
  #  upp = "77777F"
  #  assert(Traveller.noble?(upp))
  #end

  #def test_noble
  #  # Should be nil, non-noble values.
  #  upp = "77777A"
  #  gender = "male"
  #  assert(Traveller.noble(gender,upp) == "")
  #  upp = "77777G"
  #  gender = "female"
  #  assert(Traveller.noble(gender,upp) == "")
    
  #  #Should be correct.
  #  gender = "female"
  #  upp = "77777B"
  #  assert(Traveller.noble(gender, upp) == "Dame")
  #  upp = "77777C" 
  #  assert(Traveller.noble(gender, upp) == "Baroness")
  #  upp = "77777D" 
  #  assert(Traveller.noble(gender, upp) == "Marquesa")
  #  upp = "77777E" 
  #  assert(Traveller.noble(gender, upp) == "Countess")
  #  upp = "77777F" 
  #  assert(Traveller.noble(gender, upp) == "Duchess")
  #  gender = "male"
  #  upp = "77777B"
  #  assert(Traveller.noble(gender, upp) == "Knight")
  #  upp = "77777C" 
  #  assert(Traveller.noble(gender, upp) == "Baron")
  #  upp = "77777D" 
  #  assert(Traveller.noble(gender, upp) == "Marquis")
  #  upp = "77777E" 
  #  assert(Traveller.noble(gender, upp) == "Count")
  #  upp = "77777F" 
  #  assert(Traveller.noble(gender, upp) == "Duke")
  #end

  #def test_add_skill
  #  skills = Hash.new(0)
  #  skills["GunCbt"] = 2
  #  Traveller.add_skill(skills, 'GunCbt', 1)
  #  assert(skills['GunCbt'] == 3) 
  #  new_skills = {"GunCbt" => 3, "Pilot" => 1}
  #  Traveller.add_skill(skills, 'Pilot', 1)
  #  assert(skills == new_skills)
  #  very_new_skills = {"GunCbt" => 3, "Pilot" => 1, "Leader" => 1}
  #  Traveller.add_skill(skills, 'Leader')
  #  assert(skills == very_new_skills)
  #end

end
