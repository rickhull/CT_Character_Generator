#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'lib/trav_functions'
require 'lib/dice'
require 'sqlite3'
require 'optparse'
require 'character'

career = ''
options = { :career => nil }

parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.banner = "Used to create CT style characters.
  Usage: #{program_name} -c <career>"

  opts.on( '-c career', 'Select a career. Current options are:
                         Marine, Navy, Warder, College' ) do |c|
    options[:career] = c
  end
  
end
parser.parse!

career = options[:career]

# Need a failure mode if the files don't exist. 
case career
  when 'Marine'
    require 'lib/marine'
    character = Marine.new
    character.career = 'Marine'
  when 'Navy'
    require 'lib/navy'
    character = Navy.new
    character.career = 'Navy'
  when 'Warder'
    require 'lib/warder'
    character = Warder.new
    character.career = 'Warder'
  when 'College'
    require 'lib/college'
    character = College.new
    character.career = 'College'
  when 'Entertainer'
    require 'lib/entertainer'
    character = Entertainer.new
    character.career = 'Entertainer'
  when 'Guide'
    require 'lib/guide'
    character = Guide.new
    character.career = 'Guide'
  else
     abort("Sorry, I don't know how to create that sort of character.")
end

character.terms = roll1
character.set_upp
character.set_rank
character.set_name(character.gender)
character.set_skills()

###  Output section
out_txt(character)
