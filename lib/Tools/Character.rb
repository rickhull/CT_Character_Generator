class Character

  attr_accessor :gender, :name, :upp, :skills, 
      :careers, :age, :rank, :title, :stuff,
      :hair, :skin, :species, :last_career

  def initialize()
    @upp          = String.new
    @gender       = String.new
    @name         = String.new
    @species      = String.new
    @last_career  = String.new
    @skills       = Hash.new(0)
    @careers      = Hash.new(0)
    @stuff        = { "cash" => 0,
      "benefits"  => Hash.new(0)
      }
  end
 
end
