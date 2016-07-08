#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'Traveller'

roll =Traveller.roll_dice(6,2)
puts roll
