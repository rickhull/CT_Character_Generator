class Character

  attr_accessor :gender, :name, :upp, :skills, :careers, :age

  def initialize()
    @upp      = String.new
    @gender   = String.new
    @name     = String.new
    @skills   = Hash.new
    @careers  = Hash.new
  end
 
end
