#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'lib/imperial_marine'
require 'lib/trav_functions'
require 'lib/trav_arrays'
require 'lib/dice'

me = ImperialMarine.new
me.terms = average2
me.name = 'Allesandro'

#stat_names = Character::STAT_NAMES
stat_names = ImperialMarine::STAT_NAMES
stat_names.each do |stat|
  me.set_stat(stat, make_stat)
end
 
me.skills['Pilot'] = 1
me.increase_skill('Pilot', 2)
me.skills['CbtR'] = 2

### Testing how to assign ranks
commission_roll = roll2
if commission_roll >= 8
  grade_set = 'Officer'
  grade_level = me.terms
  if grade_level > 5
    grade_level = 5
  end
else
  grade_set = 'Enlisted'
  grade_level = me.terms + 2
  if grade_level > 8
    grade_level = 8
  end
end

grade = Grade[grade_set][grade_level]
me.rank = Ranks[me.career][grade]  

####  End of testing how to assign ranks.


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

