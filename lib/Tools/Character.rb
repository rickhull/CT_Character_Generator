class Character
 
  require "lib/Tools/CharacterTools.rb"
  include CharacterTools

  attr_accessor :gender, :name, :upp, :skills, 
      :careers, :age, :rank, :title, :stuff,
      :appearence, :species, 
      :hair, :skin

  def initialize(char = {})
    #@upp          = char["upp"]         || upp
    @upp          = self.upp
    puts "UPP is #{upp}"
    @gender       = char["gender"]      || gender
    @name         = char["name"]        || name
    @species      = char["species"]     || species
    @appearence   = char["appearence"]  || appearence
    @last_career  = String.new
    @skills       = Hash.new(0)
    @careers      = Hash.new(0)
    @stuff        = { "cash" => 0,
      "benefits"  => Hash.new(0)
      }
  end

end
