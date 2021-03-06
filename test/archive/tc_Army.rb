# Template for career tests

# 1. Change "Mycareer" to the name of your career.
# 2. Change the ranks array in test_rank.
# 3. Change the minimum and maximum cash amounts.
#     Just terms * lowest and highest numbers.
# 4. Add any custom tests.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "Army"
require "CharacterTools"
require "test/unit"

class TestArmy < Test::Unit::TestCase

  def setup
    #@character = CharacterTools.init
    @character = Character.new
    @character.generate
    @character.careers["Army"] = 2
    @char = Hash.new(0)
    @char["character"]  = @character
    @char["career"]     = "Army"
    @char["terms"]      = 2
    Army.new(@char)
  end

  def test_rank
    ranks = %w[ PVT LCP CPL LSGT SGT GSGT LDSGT 1SGT SGTM 2LT 1LT CPT MAJ LTC COL BG MG LG GEN ]
    assert(ranks.include?(@char["character"].rank))
  end

  def test_career
    assert(@char["career"] == "Army") 
  end

  def test_terms
    assert(@char["terms"] == 2)
  end

  def test_careers_has_key
    assert(@char["character"].careers.has_key?(@char["career"]))
  end

  def test_career_terms_correct
    assert(@char["character"].careers["Army"] ==
      @char["terms"])
  end
 
  def test_muster_out_cash
    assert(@char["character"].stuff.has_key?("cash"))
    min_cash = 2000 * (@char["terms"] / 2)
    max_cash = 30000 * (@char["terms"] / 2)
    assert(@char["character"].stuff["cash"] >= min_cash) 
    assert(@char["character"].stuff["cash"] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@char["character"].stuff.has_key?("benefits"))
    max_benefits = (@char["terms"] / 2) + 1
    assert(@char["character"].stuff["benefits"].count <= max_benefits)
  end

end
