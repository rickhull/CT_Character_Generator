#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'Traveller'

roll1 =Traveller.roll_dice(6,2)
roll2 =Traveller.roll_dice(6,2)
puts "#{roll1} vs #{roll2}"
