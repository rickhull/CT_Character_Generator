$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'PresenterDefault'
require 'Character'
class TestPresenterDefault < Test::Unit::TestCase

  def setup
    @character          = Character.new
    @character.name     = "Marco Domici"
    @character.upp      = "79AA8B"
    @character.age      = 22
    @character.skills   = {"GunCbt" => 1, "Leader" => 1}
    @character.careers  = {"Marine" => 2, "Noble" => 1}
  end

  def test_show
    test_string   = "Marco Domici  79AA8B 22  Noble: 1  Marine: 2 GunCbt-1 Leader-1"
    assert(test_string == PresenterDefault.show(@character))
  end
end
