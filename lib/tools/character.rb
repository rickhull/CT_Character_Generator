class Character

  require "tools/character_tools"

  attr_accessor :gender, :name, :upp, :skills, 
      :careers, :age, :rank, :stuff,
      :appearence, :species, :plot, :temperament

  def initialize(char = {})
    @upp          = String.new
    @gender       = String.new
    @name         = String.new
    @species      = String.new
    @appearence   = String.new
    @age          = 18
    @skills       = Hash.new(0)
    @careers      = Hash.new(0)
    @stuff        = { "cash" => 0,
      "benefits"  => Hash.new(0)
      }
  end

  def generate
    @upp          = generate_upp
    @gender       = generate_gender
    @appearence   = generate_appearence
    @species      = generate_species
    @plot         = generate_plot
    @temperament  = generate_temperament
    options       = Hash.new
    options["gender"]  = @gender
    options["species"] = @species
    @name         = generate_name(options)
  end

  def to_s
    printf("%s ", title) if noble?()
    printf("%s %s %s [%s] Age %d \n %s \n %s %s\n", 
      @name, @species.capitalize, @gender.capitalize, @upp, @age,
      @appearence,
      @temperament, @plot
      ) 
  end

  def run_career(career, terms)
    career.update_character(self, career, terms)
  end
end
