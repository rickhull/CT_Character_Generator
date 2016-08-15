
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "Marine"
require "CharacterTools"
require "test/unit"

class TestMarine < Test::Unit::TestCase

  def setup
    @character = CharacterTools.init
    @character.careers["Marine"] = 2
    @char = Hash.new(0)
    @char["character"]  = @character
    @char["career"]     = "Marine"
    @char["terms"]      = 2
    Marine.new(@char)
  end

  def test_rank
    ranks = %w[ PVT LCP CPL LSGT SGT LDSG 1SGT GSGT SMSG LT CPT FC LTC COL BG]
    assert(ranks.include?(@char["character"].rank))
  end

  def test_career
    assert(@char["career"] == "Marine") 
  end

  def test_terms
    assert(@char["terms"] == 2)
  end

  def test_careers_has_key
    assert(@char["character"].careers.has_key?(@char["career"]))
  end

  def test_career_terms_correct
    assert(@char["character"].careers["Marine"] ==
      @char["terms"])
  end
 
  def test_muster_out_cash
    assert(@char["character"].stuff.has_key?("cash"))
    min_cash = 2000 * (@char["terms"] / 2)
    max_cash = 40000 * (@char["terms"] / 2)
    assert(@char["character"].stuff["cash"] >= min_cash) 
    assert(@char["character"].stuff["cash"] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@char["character"].stuff.has_key?("benefits"))
    max_benefits = (@char["terms"] / 2) + 1
    assert(@char["character"].stuff["benefits"].count <= max_benefits)
  end

end
