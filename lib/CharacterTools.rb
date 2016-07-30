# CharacterTools implements modules for modifying Character objects.
# These methods are outside career data sets.

module CharacterTools

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  require 'Traveller'
  require 'Character'
  require 'Presenter'
  require 'json'
  require 'pp'

  STAT_NAMES = %w{Str Dex End Int Edu Soc}

  # Create a Character, with UPP, name, and gender.
  def self.init()
    character          = Character.new
    character.upp      = self.upp
    character.gender   = Traveller.gender.capitalize
    character.name     = Traveller.name(character.gender)
    character.age      = 18
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

  # Provides UPP as a 6 Hexidecimal character string.
  def self.upp
    upp = String.new
    6.times do
      stat = Traveller.roll_dice(6,2,1)
      stat = stat.to_s(16).upcase
      upp  = upp + stat
    end
    return upp
  end

  # Returns gender in lowercase, "male" or "female". Even odds.
  def self.gender
    if self.roll_dice(6,1,1) >= 4
      return 'male'
    else
      return 'female'
    end
  end

  # Increase a skill
  def self.increase_skill(character, skill, level = 1)
    if skill.split.length > 1
      amount  = skill.split[0].to_i
      stat    = skill.split[1]
      self.modify_stat(character, stat, amount)
    else
      if character.skills.has_key?(skill)
        character.skills[skill] += level 
      else
        character.skills[skill] = level
      end
    end
  end

  # Modify a stat.
  def self.modify_stat(character, stat, level)
    stat_index = STAT_NAMES.index(stat)
    new_stat = character.upp[stat_index,1].to_i(16) + level
    new_stat = [new_stat, 15].min
    new_stat = [new_stat, 2].max
    new_stat = new_stat.to_s(16).upcase
    character.upp[stat_index] = new_stat
  end

  # Adds a career and modifies the age. 
  def CharacterTools.add_career(character, career, terms)
    character.careers[career] += terms
    character.age += terms * 4
  end

  # Pull Character data into a hash.
  def self.hash_character(character)
    c_hash = Hash.new
    c_hash['name']    = character.name
    c_hash['upp']     = character.upp
    c_hash['age']     = character.age
    c_hash['careers'] = character.careers
    c_hash['skills']  = character.skills
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
      character_key.gsub!(/[ ,']/, '')
      characters[character_key] = self.hash_character(character)
      c_file = File.open(file, 'w')
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
 
  # Prints the character in some specific format. Or 'txt'
  # if unspecified. 
  def self.show_characters(file, format=json, mode='txt')
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      characters.each do |key, array|
        character = Character.new
        character.name    = characters[key]['name']
        character.upp     = characters[key]['upp']
        character.gender  = characters[key]['gender']
        character.age     = characters[key]['age']
        character.careers = characters[key]['careers']
        character.skills  = characters[key]['skills']
        Presenter.show(character, mode)
      end
    end
  end

  # Returns title if Character is a noble.
  def self.title(character)
    nobility = Hash.new
    nobility['B'] = { 'f' => 'Dame',      'm' => 'Knight' }
    nobility['C'] = { 'f' => 'Baroness',  'm' => 'Baron' }
    nobility['D'] = { 'f' => 'Marquesa',  'm' => 'Marquis' }
    nobility['E'] = { 'f' => 'Countess',  'm' => 'Count' }
    nobility['F'] = { 'f' => 'Duchess',   'm' => 'Duke' }

    title = ""
    soc = character.upp[5,1].upcase 
    
    if nobility.has_key?(soc)
      if character.gender.downcase == "female"
        title = nobility[soc]['f']
      else
        title = nobility[soc]['m']
      end 
    end
    return title
  end 

  def self.stat_modifier(options)
    stat_mod  = 0 
    upp       = options['upp']
    index     = options['index']
    minimum   = options['minimum'].to_i(16)
    modifier  = options['modifier']
    stat      = upp[index,1].to_i(16)
    stat_mod  = modifier if stat >= minimum
    return    stat_mod
  end 

end
