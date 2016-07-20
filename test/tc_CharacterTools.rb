$LOAD_PATH << File.expand_path("../../lib", __FILE__)

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

  def test_add_college

  end

  def test_stat_modifier
    options = Hash.new(0)
    options['upp'] = "777777"
    options['index'] = 5 
    options['minimum'] = "A" 
    options['modifier'] = 1 
    # This test should not provide a modifier.
    assert(CharacterTools.stat_modifier(options) == 0)
    # This test should provide a modifier.
    options['upp'] = "77777A"
    assert(CharacterTools.stat_modifier(options) == 1)
  end 


end
