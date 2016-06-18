require 'CharacterTools'

character = CharacterTools.init
CharacterTools.add_career(character, 'Navy', 2)
CharacterTools.add_career(character, 'Navy', 2)
CharacterTools.add_career(character, 'Marines', 2)

#puts "#{character.name}  #{character.gender} Age: #{character.age} #{character.upp}"
#character.careers.each do |k,v|
#  printf("%s %s terms  ", k, v)
#end
#puts

data_file = '../data/new_characters.json'
CharacterTools.save_character(character, data_file, 'json')
#CharacterTools.show_character_file(data_file, 'json')
CharacterTools.show_characters(data_file, 'json')
