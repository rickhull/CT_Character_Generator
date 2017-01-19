# Template for career tests

# 1. Change "Mycareer" to the name of your career.
# 2. Change the ranks array in test_rank.
# 3. Change the minimum and maximum cash amounts.
#     Just terms * lowest and highest numbers.
# 4. Add any custom tests.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "LEO"
require "CharacterTools"
require "test/unit"

class TestLEO < Test::Unit::TestCase

  def setup
    @character = CharacterTools.init
    @character.careers["LEO"] = 2
    @char = Hash.new(0)
    @char["character"]  = @character
    @char["career"]     = "LEO"
    @char["terms"]      = 2
    LEO.new(@char)
  end

  def test_rank
    ranks = %w[ Recruit Officer Patrol Sergeant Lieutenant Captain Chief]
    assert(ranks.include?(@char["character"].rank))
  end

  def test_career
    assert(@char["career"] == "LEO") 
  end

  def test_terms
    assert(@char["terms"] == 2)
  end

  def test_careers_has_key
    assert(@char["character"].careers.has_key?(@char["career"]))
  end

  def test_career_terms_correct
    assert(@char["character"].careers["LEO"] ==
      @char["terms"])
  end
 
  def test_muster_out_cash
    assert(@char["character"].stuff.has_key?("cash"))
    min_cash = 1000 * (@char["terms"] / 2)
    max_cash = 200000 * (@char["terms"] / 2)
    assert(@char["character"].stuff["cash"] >= min_cash) 
    assert(@char["character"].stuff["cash"] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@char["character"].stuff.has_key?("benefits"))
    max_benefits = (@char["terms"] / 2) + 1
    assert(@char["character"].stuff["benefits"].count <= max_benefits)
  end

end
