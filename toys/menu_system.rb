
require 'json'

def base(characters)
  puts "1) Search by first name"
  puts "2) Search by last name"
  puts "3) Edit character"
  puts "4) Add character"
  puts "x) Exit"
  input = gets.chomp
  case input
    when "1"  then  search_first_name(characters)
    when "2"  then  search_last_name
    when "3"  then  edit_character
    when "4"  then  add_character
    when "x"  then  exit
    else base
  end
end

def search_first_name(characters)
  puts "Enter a first name string"
  search_term = gets.chomp
  puts "Searching for '#{search_term}'."
  matches = Array.new
  matches = get_matching_ids(characters, "first_name", search_term)
  if matches.count > 0
    matches.each do |match|
      puts match
      #puts "#{match}) #{characters[match]["first_name"]} #{characters[match]["last_name"]}"
    end
  else
    puts "No results found."
  end
  base(characters)
end

def search_last_name
  puts "Enter a last name string"
  search_term = gets.chomp
  puts "Searching for '#{search_term}'."
  puts "No results found."
  base
end

def get_matching_ids(hash, key, search_term)
  matches = Array.new
  hash.keys.each do |id|
    if hash[id][key].downcase.include?(search_term.downcase)
      puts hash[id][key]
      matches << id
    end
  end
  return matches
end

def edit_character
  puts "Which character ID?"
  search_term = gets.chomp
  puts "Searching for '#{search_term}'."
  puts "No results found."
  base
end

def add_character
  puts "Not ready to add a character yet."
  base
end

def data_to_json(file)
  character_raw_data = File.read(file)
  characters = JSON.parse(character_raw_data)
  return characters
  #puts characters["0"].keys
end

def build_character_data
  
end
  
## Main ##
#first_names = Array.new
#last_names = Array.new
characters = Hash.new
characters = data_to_json('../data/blue_dragon_roster.json')
base(characters)
