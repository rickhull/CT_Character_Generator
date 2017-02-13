# CharacterTools implements modules for modifying Character objects.
# These methods are outside career data sets.

module CharacterTools


  $DATA_PATH  = File.expand_path("../../../data", __FILE__)
  require "Traveller"
  #require "Presenter"
  require "Name"
  #require "json"
  #require "pp"

  # Provides UPP as a 6 Hexidecimal character string.
  def generate_upp
    new_upp = String.new
    6.times do
      stat = Traveller.roll_dice(6,2,1)
      stat = stat.to_s(16).upcase
      new_upp  = new_upp + stat
    end
    return new_upp
  end

  def generate_gender
    if Traveller.roll_dice(6,1,1) >= 4
      gender = "male"
    else
      gender = "female"
    end
    return gender
  end
 
  def generate_appearence
    app = String.new
    skin = generate_skin
    hair = generate_hair
    app << hair + " hair "
    app << skin + " skin"
    return app
  end

  def generate_hair
    begin
      t = get_random_line_from_file("hair_tone.txt")
      b = get_random_line_from_file("hair_body.txt")
      c = get_random_line_from_file("hair_colors.txt")
      l = get_random_line_from_file("hair_length.txt")
      new_hair = "#{b} #{t} #{c} #{l}"
    rescue SystemCallError => e
      new_hair = "Straight medium brown short" 
    end
    return new_hair
  end

  def generate_skin
    begin
      skin_tone =  get_random_line_from_file("skin_tones.txt")
    rescue SystemCallError => e
      skin_tone = "medium"
    end
    return skin_tone 
  end
  
  def generate_name(options)
    Name.new(options).to_s
  end
  
  def generate_species
    return "humaniti"
  end
 
  STAT_NAMES = %w{Str Dex End Int Edu Soc}
  # Create a Character, with UPP, name, and gender.
  def self.init
    character          = Character.new
    character.upp      = self.upp
    character.gender   = self.gender.capitalize
    character.species = "humaniti"
    options           = { "gender" => character.gender, "species" => character.species }
    character.name     = Name.new(options).to_s
    character.age      = 18
    character.hair     = self.hair
    character.skin     = self.skin
    return character
  end


  # Return general social status based on Soc.
  def self.social_status(character)
    soc = character.upp[5,1].to_i(16)
    status = case soc     
      when 0..5   then  "Other"
      when 11..15 then  "Noble"
      else              "Citizen"
    end
    return status 
  end
  
  # Increase a skill
  def self.increase_skill(options)
  # Assume an options hash is passed. 
    character = options["character"]
    skill     = options["skill"] 
    level     = options.has_key?("level") ? options["level"] : 1
    if skill.split.length > 1
      options["stat_level"] = skill.split[0].to_i
      options["stat"]       = skill.split[1]
      self.modify_stat(options)
    else
      if character.skills.has_key?(skill)
        character.skills[skill] += level 
      else
        character.skills[skill] = level
      end
    end
  end

  # Modify a stat.
  def self.modify_stat(options)
    begin
      character = options["character"]
      stat      = options["stat"]
      #return    unless STAT_NAMES.include?(stat) and character.upp.length > 5
      stat_level     = options.has_key?("stat_level") ? options["stat_level"] : 1
      stat_index = STAT_NAMES.index(stat)
      raise ArgumentError unless character.upp =~ /[0-9A-F]/
      new_stat = character.upp[stat_index,1].to_i(16) + stat_level
      new_stat = [new_stat, 15].min
      new_stat = [new_stat, 2].max
      new_stat = new_stat.to_s(16).upcase
      character.upp[stat_index] = new_stat
    rescue TypeError => wrong_type
      #$stderr.puts "Input error type failure: #{wrong_type}."
      raise
    rescue ArgumentError => bad_arg
      #$stderr.print "Bad argument: #{bad_arg}."
      raise
    end
  end

  # Adds a career and modifies the age. 
  def CharacterTools.add_career(char)
    terms         = char["terms"]
    career        = char["career"]
    character     = char["character"]
    character.age += terms * 4
    #character.careers[career] += terms
    career_string = "#{career}-#{terms}"
    character.careers << career_string
  end

  # Pull Character data into a hash.
  def self.hash_character(character)
    c_hash = Hash.new
    c_hash["name"]    = character.name
    c_hash["upp"]     = character.upp
    c_hash["age"]     = character.age
    c_hash["careers"] = character.careers
    c_hash["skills"]  = character.skills
    return c_hash
  end

  # Save the Character data.
  # Still not sure on this one. It works for the moment.
  def self.save_character(character, file, format=json)
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in) 
      character_key = "#{character.upp}-#{character.name}"
      character_key.gsub!(/[ ,']/, "")
      characters[character_key] = self.hash_character(character)
      c_file = File.open(file, "w")
      c_file.write(JSON.pretty_generate(characters))
      c_file.close
    end
  end

  # Prints the character file in Pretty JSON.
  def self.show_character_file(file, format=json)
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      puts JSON.pretty_generate(characters) 
    end
  end

  def self.show_one_character(character, mode = "txt")
    Presenter.show(character, mode)
  end
 
  # Prints the character in some specific format. Or "txt"
  # if unspecified. 
  def self.show_characters(file, format=json, mode="txt")
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      characters.each do |key, array|
        character = Character.new
        character.name    = characters[key]["name"]
        character.upp     = characters[key]["upp"]
        character.gender  = characters[key]["gender"]
        character.age     = characters[key]["age"]
        character.careers = characters[key]["careers"]
        character.skills  = characters[key]["skills"]
        Presenter.show(character, mode)
      end
    end
  end

  # Sets and Returns title if Character is a noble.
  def self.title(character)
    nobility = Hash.new
    nobility["B"] = { "f" => "Dame",      "m" => "Knight" }
    nobility["C"] = { "f" => "Baroness",  "m" => "Baron" }
    nobility["D"] = { "f" => "Marquesa",  "m" => "Marquis" }
    nobility["E"] = { "f" => "Countess",  "m" => "Count" }
    nobility["F"] = { "f" => "Duchess",   "m" => "Duke" }

    #title = ""
    soc = character.upp[5,1].upcase 
    
    if nobility.has_key?(soc)
      if character.gender.downcase == "female"
        title = nobility[soc]["f"]
        character.title = title
      else
        title = nobility[soc]["m"]
        character.title = title
      end 
    end
    return title
  end 

  def self.stat_modifier(options)
    stat_mod  = 0 
    upp       = options["character"].upp
    index     = options["index"]
    minimum   = options["minimum"].to_i(16)
    modifier  = options["modifier"]
    stat      = upp[index,1].to_i(16)
    stat_mod  = modifier if stat >= minimum
    return    stat_mod
  end 

  def get_random_line_from_file(file)
    begin 
      fname       = $DATA_PATH + "/" + file
      new_file    = File.open(fname, "r")
      new_array   = Array.new
      new_file.each do |line|
        line.chomp!
        if line !~ /#/ and line.length > 4
          new_array << line
        end
      end
      result = new_array[rand(new_array.length - 1)]
    rescue SystemCallError
      raise 
    ensure
      new_file.close() unless new_file.nil?
    end
    return result
  end
  def generate_plot
    begin
      plot = get_random_line_from_file("plots.txt")
    rescue SystemCallError => e
      puts e.to_s
      plot = "Some drab plot"
    end
    return plot
  end

  def generate_temperament
    return get_random_line_from_file("temperaments.txt")
  end

  def self.morale(options = "")
    morale   = Traveller.roll_dice(1,6,1)
    if options.class == Hash and options["character"].careers.length > 0
      high_morales    = ["Marine", "Army"]
      medium_morales  = ["Navy", "Scout"]
      options["character"].careers.each do |career, terms|
        morale += (1 * terms)      if high_morales.include?(career)
        morale += (0.5 * terms)    if high_morales.include?(career)
      end 
    end
    return morale
  end

  module_function :get_random_line_from_file
  module_function :generate_temperament
  module_function :generate_plot

end
