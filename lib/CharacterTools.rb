module CharacterTools

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  require 'Traveller'
  require 'Character'

  def self.init()
    character          = Character.new
    character.upp      = Traveller.upp
    character.gender   = Traveller.gender.capitalize
    character.name     = Traveller.name(character.gender)
    character.age      = 18
    return character
  end
  
end
