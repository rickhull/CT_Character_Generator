#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

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

#data_file = '../data/lot_of_chars.json'
output_format = 'hash'
chars = Hash.new

career = 'Marine'
character = gen_char(career)
char_id = "#{character.upp}-#{character.name}"
chars[char_id] = Hash.new
chars[char_id] = Traveller.write(character, output_format)

puts JSON.pretty_generate(chars)
