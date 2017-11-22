# Template for career tests

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "Guide"
require "CharacterTools"
require "test/unit"

class TestGuide < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
    @character.careers["Guide"] = 2
    @char = Hash.new(0)
    @char["character"]  = @character
    @char["career"]     = "Guide"
    @char["terms"]      = 2
    Guide.new(@char)
  end

  def test_rank
    assert(@char["character"].rank == nil)
  end

  def test_career
    assert(@char["career"] == "Guide") 
  end

  def test_terms
    assert(@char["terms"] == 2)
  end

  def test_careers_has_key
    assert(@char["character"].careers.has_key?(@char["career"]))
  end

  def test_career_terms_correct
    assert(@char["character"].careers["Guide"] == @char["terms"])
  end
 
  def test_muster_out_cash
    assert(@char["character"].stuff.has_key?("cash"))
    min_cash = 1000 * (@char["terms"] / 2)
    max_cash = 20000 * (@char["terms"] / 2)
    assert(@char["character"].stuff["cash"] >= min_cash) 
    assert(@char["character"].stuff["cash"] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@char["character"].stuff.has_key?("benefits"))
    max_benefits = (@char["terms"] / 2) + 1
    assert(@char["character"].stuff["benefits"].count <= max_benefits)
  end

end
