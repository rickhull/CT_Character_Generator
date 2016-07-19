require 'CharacterTools'

character = CharacterTools.init
careers = ['Navy', 'Scout', 'Merchant', 'Army', 'Marine', 'Other']
career_choice = rand(careers.length)
career = careers[career_choice]
terms = rand(5) + 1
CharacterTools.add_career(character, career, terms)

data_file = '../data/new_characters.json'
CharacterTools.save_character(character, data_file, 'json')
CharacterTools.show_characters(data_file, 'json', 'txt')
