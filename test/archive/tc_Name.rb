

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "test/unit"
require "Name"

class TestName < Test::Unit::TestCase

  def test_female_humaniti_name_length
    @options = { "gender" => "female", "species" => "humaniti"}
    @name = Name.new(@options).to_s
    assert(@name.length > 4)
    assert(@name.length < 50)
  end
  
  def test_male_humaniti_name_length
    @options = { "gender" => "male", "species" => "humaniti"}
    @name = Name.new(@options).to_s
    assert(@name.length > 4)
    assert(@name.length < 50)
  end
  
end
