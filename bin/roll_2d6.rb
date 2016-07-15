#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'Traveller'

if Integer(ARGV[0]) > 1
  rolls = Integer(ARGV[0])
else
  rolls = 1
end

rolls.times do 
  puts Traveller.roll_dice(6,2)
end
