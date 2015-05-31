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
  opts.banner = "Usage: chargen -c <career>"

  opts.on( '-c career') do |c|
    options[:career] = c
  end
  
end
parser.parse!
career = options[:career]

  
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
  else
     abort("Sorry, I don't know how to create that sort of character.")
end

character.terms = average2
character.set_upp
character.set_rank

# Set name
character.set_name(character.gender)

# Skills depends on the career and terms
character.set_skills()


###  Output section
puts "#{character.career} #{character.rank} #{character.name} #{character.upp} Gender #{character.gender.capitalize} Age #{character.age}  #{character.terms} terms"
first_skill = true
character.skills.each do |skill, level|
  if first_skill == false
    print ", "
  end
  print "#{skill}-#{level}"
  first_skill = false
end
print "\n"

#####  End of output section.

