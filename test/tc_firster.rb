# Testing the Firster class.

require "test/unit"
require "tools/character_tools"
require "careers/firster"

class TestFirster < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
    @career = "Firster"
    these_terms  = 2
    @character.careers[@career] = these_terms
    @half_terms = (@character.careers[@career] / 2) + 1
    this_career = Module.const_get(@career).new
    @character.run_career(this_career, these_terms)
  end

  def test_career
    assert(@character.careers.key?(@career))
  end

  def test_terms
    assert(@character.careers[@career] == 2)
  end

  def test_muster_out_cash
    assert(@character.stuff.has_key?('cash'))
    min_cash = 10000 * @half_terms
    max_cash = 200000 * @half_terms
    assert(@character.stuff["cash"] >= min_cash) 
    assert(@character.stuff['cash'] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@character.stuff.has_key?('benefits'))
    assert(@character.stuff['benefits'].count <= @half_terms)
  end

end
