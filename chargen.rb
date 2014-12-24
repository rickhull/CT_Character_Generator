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
    require 'lib/imperial_marine'
    character = ImperialMarine.new
    character.set_upp
    character.career = 'Marine'
    character.set_rank()
  else
     abort("Sorry, I don't know how to create that sort of character.")
end

# Set name
character.set_name(character.gender)

# Generate the UPP 
# Really, this should be done before the career is chosen. 
# Ideally, anyway. Not required for this.
#stat_names = Character::STAT_NAMES
#stat_names.each do |stat|
#  character.set_stat(stat, make_stat)
#end

# Terms defines age and affects skills
character.terms = average2

# Skills depends on the career and terms
character.set_skills()


###  Output section
puts "#{character.career} #{character.rank} #{character.name} #{character.upp} Age #{character.age}  #{character.terms} terms"
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

