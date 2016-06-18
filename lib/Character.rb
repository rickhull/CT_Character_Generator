class Character


  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  attr_accessor :gender, :name, :upp, :skills, :careers, :age
                # :officer, :morale, :rank, :terms,
                # :awards, :wounds, :title

  def initialize()
    @upp      = String.new
    @gender   = String.new
    @name     = String.new
    @skills   = Hash.new
    @careers  = Hash.new
    @age      = 18
  end
  
end
