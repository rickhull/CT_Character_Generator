#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'lib/imperial_marine'
require 'lib/trav_functions'
require 'lib/dice'

me = ImperialMarine.new
# me.terms = average2
me.name = 'Allesandro'

stat_names = ImperialMarine::STAT_NAMES
stat_names.each do |stat|
  me.set_stat(stat, make_stat)
end
 
# me.skills['Pilot'] = 1
# me.increase_skill('Pilot', 2)
# me.skills['CbtR'] = 2

me.set_rank()
me.set_skills()

###  Output section
puts "#{me.career} #{me.rank} #{me.name} #{me.upp} Age #{me.age}  #{me.terms} terms"
first_skill = true
me.skills.each do |skill, level|
  if first_skill == false
    print ", "
  end
  print "#{skill}-#{level}"
  first_skill = false
end
print "\n"

#####  End of output section.

