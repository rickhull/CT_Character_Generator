class Character


  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  require 'Traveller'
  attr_accessor :gender, :name, :upp
                # :career, :officer, :morale, :rank, :terms,
                # :awards, :wounds, :skills, :age, :title

  def initialize()
    @upp      = Traveller.upp
    @gender   = Traveller.gender.capitalize
    @name     = Traveller.name(@gender)
  end
  
end
