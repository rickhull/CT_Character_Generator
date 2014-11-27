#!/usr/bin/env ruby

require 'lib/character'
require 'lib/trav_functions'
require 'lib/trav_arrays'
require 'lib/dice'

me = Character.new
me.terms = average2
me.career = set_career
me.name = 'Allesandro'

stat_names = Character::STAT_NAMES
stat_names.each do |stat|
  me.set_stat(stat, make_stat)
end
 
me.skills['Pilot'] = 1
me.increase_skill('Pilot', 2)
me.skills['CbtR'] = 2

puts "#{me.career} #{me.name} #{me.upp} Age #{me.age}  #{me.terms} terms"
first_skill = true
me.skills.each do |skill, level|
  if first_skill == false
    print ", "
  end
  print "#{skill}-#{level}"
  first_skill = false
end
print "\n"

# test_career = 'Marines'
# test_grade = 'E3'
# puts "Rank is #{Ranks[test_career][test_grade]}."


