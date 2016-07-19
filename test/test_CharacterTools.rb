$LOAD_PATH << File.expand_path("../../lib", __FILE__)

# Note the following error which needs to be researched:
# /usr/lib64/ruby/site_ruby/1.8/x86_64-linux/sqlite3_api.so: warning: global variable `$swig_runtime_data_type_pointer2' not initialized

require "test/unit"
require "CharacterTools"

class TestCharacterTools < Test::Unit::TestCase

  def setup
    @character = CharacterTools.init
  end

  def test_age
    assert(@character.age == 18) 
  end

  def test_add_career
    terms = 2
    career = "Scout"
    CharacterTools.add_career(@character, career, terms)
    assert(@character.age == 18 + (terms * 4))
    assert(@character.careers.has_key?(career))
    assert(@character.careers[career] == terms) 
  end

  def test_add_second_career
    terms = 2
    career = "Scout"
    CharacterTools.add_career(@character, career, terms)
    terms2 = 1
    career2 = "Merchant"
    CharacterTools.add_career(@character, career2, terms2)
    assert(@character.age == 18 + ((terms + terms2) * 4))
    assert(@character.careers.has_key?(career))
    assert(@character.careers[career] == terms) 
    assert(@character.careers.has_key?(career2))
    assert(@character.careers[career2] == terms2) 
  end

end
