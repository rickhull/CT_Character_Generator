# Testing the Citizen class.

# Note that this is currently failing in test_career, and more.
# Sample output
#
# Loaded suite test/ts_CT_Character_Generator
# Started
# ................................. career is Citizen
#  career.class is Class
#  terms is 2
# As key 0
# Hash
# F
# ===============================================================================
# Failure: <false> is not true.
# test_career(TestCitizen)
# /home/leam/lang/git/CT_Character_Generator/test/tc_Citizen.rb:27:in `test_career'
#      24:       puts "As key #{@character.careers["Citizen"]}"
#      25:     end
#      26:     puts @character.careers.class
#   => 27:     assert(@character.careers["Citizen"] == 2)
#      28:   end
#      29: 
#      30:   def test_terms
#  ===============================================================================

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "test/unit"
require "CharacterTools"
require "Citizen"

class TestCitizen < Test::Unit::TestCase

  def setup
    @character = Character.new
    @character.generate
    @career = "Citizen"
    @this_career = Module.const_get(@career).new
    @character.run_career(@this_career, 2)
  end

  def test_career
    #@character.careers.each_pair do |career, terms|
    #  puts " career is #{career}"
    #  puts " career.class is #{career.class}"
    #  puts " terms is #{terms}"
    #  puts "As key #{@character.careers["Citizen"]}"
    #end
    #puts @character.careers.class
    assert(@character.careers.key?(Citizen))
  end

  def test_terms
    assert(@character.careers[Citizen] == 2)
  end

  #def test_muster_out_cash
  #  assert(@char['character'].stuff.has_key?('cash'))
  #  min_cash = 1000 * (@char['terms'] / 2)
  #  max_cash = 9000 * (@char['terms'] / 2)
  #  assert(@char['character'].stuff['cash'] >= min_cash) 
  #  assert(@char['character'].stuff['cash'] <= max_cash) 
  #end 

  #def test_muster_out_benefits
  #  assert(@char['character'].stuff.has_key?('benefits'))
  #  max_benefits = (@char['terms'] / 2) + 1
  #  assert(@char['character'].stuff['benefits'].count <= max_benefits)
  #end

end
