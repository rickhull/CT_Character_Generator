#!/usr/bin/env ruby

require 'json'

character_file = File.read('battle_results.json')
unit = JSON.parse(character_file)
#puts JSON.pretty_generate(unit)

def sort_trooper(trooper)
  print "Trooper ID: #{trooper[0]}:  "
  this_trooper = Hash.new
  this_trooper = trooper[1]
  print " #{this_trooper['rank']} "
  print " #{this_trooper['first_name']}"
  puts " #{this_trooper['last_name']}"
end

trooper_count = unit.count
unit.each do |trooper|
  sort_trooper(trooper)
end

modify_trooper = 'y'
until modify_trooper == 'n'

  puts "Enter Trooper ID to Modify. "
  trooper_to_modify = gets.chomp
  puts JSON.pretty_generate(unit[trooper_to_modify])

  puts "What field? "
  field = gets.chomp
  puts "New data: "
  new_data = gets.chomp

  unit[trooper_to_modify][field] = new_data
  puts JSON.pretty_generate(unit[trooper_to_modify])
  puts "You just updated trooper number #{trooper_to_modify}."
  puts "Modify another? "
  modify_trooper = gets.chomp
end

out_file = File.open('battle_results.json', 'w')
out_file.write(JSON.pretty_generate(unit))




