$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'CharacterTools'

character = CharacterTools.init
#CharacterTools.show_one_character(character, 'txt')
careers = ['Navy', 'Scout', 'Merchant', 'Army', 'Marine', 'Other']
#career = careers[rand(careers.length)]
terms = rand(5) + 1
#character.careers["Citizen"] = terms
#CharacterTools.show_one_character(character, 'txt')
#CharacterTools.add_career(character, career, terms)
CharacterTools.show_one_character(character, "txt")

status = CharacterTools.social_status(character)
case status 
  when "Noble" then
    career = "Noble"
    CharacterTools.add_career(character, career, terms)
    require "Noble"
    Noble.run_career(character)
  when "Other" then
    career = "Other"
    CharacterTools.add_career(character, career, terms)
    require "Other"
    Other.run_career(character)
  else
    career = "Citizen"
    CharacterTools.add_career(character, career, terms)
    require "Citizen"
    Citizen.run_career(character)
end

CharacterTools.show_one_character(character, 'txt')

#CharacterTools.add_career(character, career, terms)

#data_file = '../data/new_characters.json'
#CharacterTools.save_character(character, data_file, 'json')
#CharacterTools.show_characters(data_file, 'json', 'txt')
