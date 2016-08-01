# Testing the Citizen class.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'Citizen'
require 'CharacterTools'

class TestCitizen < Test::Unit::TestCase

  def setup
    @character = CharacterTools.init
    @character.careers['Citizen'] = 2
    @char = Hash.new(0)
    @char['character']  = @character
    @char['career']     = "Citizen"
    @char['terms']      = 2
    Citizen.run_career(@char)
  end

  def test_career
    assert(@char['career'] == "Citizen") 
  end

  def test_terms
    assert(@char['terms'] == 2)
  end

  def test_careers_has_key
    assert(@char['character'].careers.has_key?(@char['career']))
  end

  def test_career_terms_correct
    assert(@char['character'].careers['Citizen'] ==
      @char['terms'])
  end
 
  def test_muster_out_cash
    assert(@char['character'].stuff.has_key?('cash'))
    min_cash = 1000 * (@char['terms'] / 2)
    max_cash = 9000 * (@char['terms'] / 2)
    assert(@char['character'].stuff['cash'] >= min_cash) 
    assert(@char['character'].stuff['cash'] <= max_cash) 
  end 

  def test_muster_out_benefits
    assert(@char['character'].stuff.has_key?('benefits'))
    max_benefits = (@char['terms'] / 2) + 1
    assert(@char['character'].stuff['benefits'].count <= max_benefits)
  end

  #def test_char_hash
  #  pp @char
  #end
end
