class Character

  attr_accessor :gender, :name, :upp, :skills, :careers, :age, :rank, :title

  def initialize()
    @upp      = String.new
    @gender   = String.new
    @name     = String.new
    @skills   = Hash.new(0)
    @careers  = Hash.new(0)
  end
 
end
