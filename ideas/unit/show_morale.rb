#!/usr/bin/env ruby

require 'json'
require 'pp'

character_file = File.read('battle_results.json')
unit = JSON.parse(character_file)

unit.sort.each do |trooper|
  this_trooper = Hash.new
  this_trooper = trooper[1]
  print "#{trooper[0]}  "
  print " #{this_trooper['rank']} #{this_trooper['first_name']} #{this_trooper['last_name']}  "
  puts "Morale #{this_trooper['morale']}"
end

#unit_max = unit.count - 1
# puts unit.class
#pp unit["43"]

def show_trooper(trooper)
  this_trooper = Hash.new
  this_trooper = trooper[1]
  line1 = %w[ rank first_name last_name ]
  line1.each do |item|
    print "#{this_trooper[item]} "
  end
  puts "Morale: #{this_trooper['morale']} "
end

#show_trooper(unit["43"])
#(0..unit_max).each do |index|
#  index = index.to_s
#  print "#{index} "
#  puts unit[index]['rank']
#end

# first_squad = [ 1, 2, 3, 4]

#unit.keys.each do |key|
#  puts key
#end

#first_squad.each do |id|
#unit.each do |key, trooper|
#  show_trooper(trooper)
  #id = id.to_s
  #puts "id is #{id}."
  #puts id.class
  #trooper = unit[id] 
#  show_trooper(trooper)
#end


