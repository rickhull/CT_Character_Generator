require 'CharacterTools'

character = CharacterTools.init
#CharacterTools.add_career(character, 'Navy', 2)
#CharacterTools.add_career(character, 'Navy', 2)
#CharacterTools.add_career(character, 'Marine', 2)

CharacterTools.add_career(character, 'Marine', 1)


data_file = '../data/new_characters.json'
CharacterTools.save_character(character, data_file, 'json')
CharacterTools.show_characters(data_file, 'json', 'txt')
