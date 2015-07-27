#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'lib/trav_functions'
require 'lib/dice'
require 'sqlite3'
require 'optparse'
require 'character'
require 'Chargen'

def gen_char(career)
  # Need a failure mode if the files don't exist. 
  name = career.capitalize
  character = Chargen.const_get(name).new
  character.career = name
  character.terms = roll1
  character.set_upp
  character.set_rank
  character.set_name(character.gender)
  character.set_skills()
  return character
end

career = 'Citizen'

parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.banner = "Used to create CT style characters.
  Usage: #{program_name} -c <career>"

  opts.on( '-c career', 'Select a career. Current options are:
                         Marine, Navy, Scout, Warder, College,
                         Citizen, Guide, Entertainer' ) do |c|
    career = c
  end
end
parser.parse!

character = gen_char(career)

out_txt(character)
