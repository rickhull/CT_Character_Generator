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
    character.gender   = self.gender.capitalize
    character.name     = self.name(character.gender)
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
    if Traveller.roll_dice(6,1,1) >= 4
      return 'male'
    else
      return 'female'
    end
  end

  # Pulls a first name from the database, based on gender. 
  # Gender required but defaults to male.
  # Requires sqlite3 functionality and the database file.
  def self.first_name(gender='Male')
    require 'sqlite3'
    gender = gender.downcase
    begin 
      db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
      first_name_query = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
      first_name_result = first_name_query.execute
      first_name = first_name_result.first
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      first_name_query.close if first_name_query
      db.close if db
    end
    return first_name.to_s
  end

  # Pulls a last name from the database. In the future based on culture. 
  # Requires sqlite3 functionality and the database file.
  def self.last_name
    require 'sqlite3'
    begin 
      db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
      last_name_query = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
      last_name_result = last_name_query.execute
      last_name = last_name_result.first
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      last_name_query.close if last_name_query
      db.close if db
    end
    return last_name.to_s
  end

  # Needs gender, produces first and last name as a single string.
  def self.name(gender)
    first_name  = self.first_name(gender)
    last_name   = self.last_name
    return "#{first_name} #{last_name}"
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
  def CharacterTools.add_career(char)
    terms         = char['terms']
    career        = char['career']
    character     = char['character']
    character.age += terms * 4
    character.careers[career] += terms
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

  # Sets and Returns title if Character is a noble.
  def self.title(character)
    nobility = Hash.new
    nobility['B'] = { 'f' => 'Dame',      'm' => 'Knight' }
    nobility['C'] = { 'f' => 'Baroness',  'm' => 'Baron' }
    nobility['D'] = { 'f' => 'Marquesa',  'm' => 'Marquis' }
    nobility['E'] = { 'f' => 'Countess',  'm' => 'Count' }
    nobility['F'] = { 'f' => 'Duchess',   'm' => 'Duke' }

    #title = ""
    soc = character.upp[5,1].upcase 
    
    if nobility.has_key?(soc)
      if character.gender.downcase == "female"
        title = nobility[soc]['f']
        character.title = title
      else
        title = nobility[soc]['m']
        character.title = title
      end 
    end
    return title
  end 

  def self.stat_modifier(options)
    stat_mod  = 0 
    upp       = options['character'].upp
    index     = options['index']
    minimum   = options['minimum'].to_i(16)
    modifier  = options['modifier']
    stat      = upp[index,1].to_i(16)
    stat_mod  = modifier if stat >= minimum
    return    stat_mod
  end 

  def self.hair
    tone = ['light', 'medium', 'full' ]
    body = ['straight', 'wavey', 'curly', 'frizzed']
    color = ['blond', 
        'auburn',
        'brown',
        'chestnut',
        'red',
        'orange',
        'green',
        'blue',
        'black',
        'white',
        'gold',
        'silver',
        'yellow',
        'gray'
      ]
    length  = ['close cropped',
        'short',
        'medium length',
        'shoulder length',
        'very long',
        'waist length'
      ]

    t = tone[rand(tone.length)]
    b = body[rand(body.length)].capitalize
    c = color[rand(color.length)]
    l = length[rand(length.length)]
  
    hair = "#{b} #{t} #{c} #{l}"
    return hair
  end

  def self.skin
    skin_tone = ['albino',
      'pale',
      'medium',
      'tanned',
      'brown',
      'chocolate',
      'black',
      'blue',
      'gold',
      'green',
      'silver',
      'translucent',
      'orange'
    ]
    return skin_tone[rand(skin_tone.length)]
  end

end
