#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'lib/trav_functions'
require 'lib/dice'
require 'sqlite3'
require 'optparse'
require 'character'
require 'Chargen'

#options = { :career => nil }
career = ''

parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.banner = "Used to create CT style characters.
  Usage: #{program_name} -c <career>"

  opts.on( '-c career', 'Select a career. Current options are:
                         Marine, Navy, Scout, Warder, College,
                         Guide, Entertainer' ) do |c|
    #options[:career] = c
    career = c
  end
  
end
parser.parse!

#career = options[:career]

# Need a failure mode if the files don't exist. 
name = career.capitalize
character = Chargen.const_get(name).new
character.career = name


character.terms = roll1
character.set_upp
character.set_rank
character.set_name(character.gender)
character.set_skills()

###  Output section
out_txt(character)
print_mental()
