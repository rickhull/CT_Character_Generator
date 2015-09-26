#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
$DATA_PATH = File.expand_path("../../data", __FILE__)

require 'Traveller'

require 'sqlite3'
require 'character'
require 'Chargen'
require 'json'
require 'pp'

def gen_char(career)
  # Need a failure mode if the files don't exist. 
  name = career.capitalize
  character = Chargen.const_get(name).new
  character.career = name
  character.terms = Traveller.roll_dice(6,1,1)
  character.upp
  character.set_rank
  character.set_name(character.gender)
  character.set_skills()
  return character
end

output_format = 'hash'
chars = Hash.new

newbies = {'Mountainman' => 3, 'Warder' => 2, 'Path' => 3, 'Citizen' => 2, 'Guide' => 1 }
newbies.each do  |career, count| 
  count.times do
    character = gen_char(career)
    char_id = "#{character.upp}-#{character.name}"
    chars[char_id] = Hash.new
    chars[char_id] = Traveller.write(character, output_format)
  end
end

#puts JSON.pretty_generate(chars)
data_file = File.open("#{$DATA_PATH}/lot_of_chars.json", 'w')
data_file.write(JSON.pretty_generate(chars))


newbies.each_key do |key|
  puts
  puts  "Looking at #{key} people."
  chars.each_key do |char|
    if chars[char]['career'] == key
      puts "#{chars[char]['name']}"
    end
  end
end
 
