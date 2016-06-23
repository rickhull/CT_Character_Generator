module CharacterTools

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  require 'Traveller'
  require 'Character'
  require 'Presenter'
  require 'json'
  require 'pp'

  def self.init()
    character          = Character.new
    character.upp      = Traveller.upp
    character.gender   = Traveller.gender.capitalize
    character.name     = Traveller.name(character.gender)
    character.age      = 18
    return character
  end

  def CharacterTools.add_career(character, career, terms)
    if character.careers.has_key?(career)
      character.careers[career] += terms
    else
      character.careers[career] = terms
    end
    character.age += terms * 4
    if career == "Marine"
      require 'Marine'
      Marine.first_term(character)
    end
  end

  def self.hash_character(character)
    c_hash = Hash.new
    c_hash['name']    = character.name
    c_hash['upp']     = character.upp
    c_hash['age']     = character.age
    c_hash['careers'] = character.careers
    c_hash['skills']  = character.skills
    return c_hash
  end

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

  def self.show_character_file(file, format=json)
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      puts JSON.pretty_generate(characters) 
    end
  end
  
  def self.show_characters(file, format=json, mode='txt')
    if File.exists?(file)
      characters = Hash.new
      characters_in = File.read(file)
      characters = JSON.parse(characters_in)
      #characters.each do |character|
      #  puts characters[character]
      #  #Presenter.show(character, mode)
      #end
      characters.each do |key, array|
        character = Character.new
        character.name    = characters[key]['name']
        character.upp     = characters[key]['upp']
        character.gender  = characters[key]['gender']
        character.age     = characters[key]['age']
        Presenter.show(character, mode)
      end
      #  printf("%s ", characters[key]['name'])
      #  printf("%s ", characters[key]['upp'])
      #  printf("%s ", characters[key]['gender'])
      #  printf("Age: %s ", characters[key]['age'])
      #  puts
      #  characters[key]['careers'].each do |career, terms|
      #    printf("%s %s ", career, terms)
      #  end
      #  puts
      #end
    end
  end

end
