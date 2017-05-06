# Testing the Noble class.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "test/unit"
require "CharacterTools"
require "Noble"

class TestNoble < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
    @career = "Noble"
    these_terms  = 2
    @half_terms = (@character.careers[@career] / 2) + 1
    @character.careers[@career] = these_terms
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

  def test_title_knight
    @character.upp = "77777B"
    @character.gender = "M"
    assert(@character.title == "Knight")
  end
end
