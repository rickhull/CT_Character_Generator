#!/usr/bin/env ruby

require 'json'
require 'pp'

character_file = File.read('blue_dragon_roster.json')
unit = JSON.parse(character_file)
unit_array = Array.new

unit.sort.each do |trooper|
  this_trooper = Hash.new
  this_trooper = trooper[1]
  #print "#{trooper[0]}  "
  #string = "#{this_trooper['rank']} #{this_trooper['first_name']} #{this_trooper['last_name']}  "
  #print " #{this_trooper['rank']} #{this_trooper['first_name']} #{this_trooper['last_name']}  "
  #puts "Morale #{this_trooper['morale']}"
  index = trooper[0].to_i
  string = index.to_s
  %w[ rank first_name last_name morale ].each do |key|
    string = "#{string} " + "#{this_trooper[key]}"
  end
  #puts "string is #{string}."
  unit_array[index] = string
end

unit_array.each do |line|
  puts line
end

