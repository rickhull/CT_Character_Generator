$LOAD_PATH << File.expand_path("../../lib/Tools", __FILE__)

require "Character"
require "test/unit"

class TestCharacter < Test::Unit::TestCase

  def setup
    @base_character = Character.new
    @character      = Character.new
    @character.generate
  end

  def test_no_upp
    assert(@base_character.upp == "")
  end 

  def test_has_upp
    assert(@character.upp.length > 3)
  end

  def test_has_no_gender
    assert(@base_character.gender == "")
  end

  def test_has_gender
    genders = ["male", "female"]
    assert(genders.include?(@character.gender))
  end

  def test_has_no_appearence
    assert(@base_character.appearence == "")
  end

  def test_appearence_is_string
    assert(@character.appearence.class == String)
  end
  
  def test_appearence_is_longer_than_ten_characters
    assert(@character.appearence.length > 10)
  end

  def test_has_no_name
    assert(@base_character.name == "")
  end

  def test_has_name
    assert(@character.name.length > 5)
  end

  def test_has_age
    assert(@base_character.age == 18)
  end

end
