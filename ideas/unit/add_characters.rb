#!/usr/bin/env ruby

require 'json'

character_file = File.read('blue_dragon_roster.json')
unit = JSON.parse(character_file)
unit_keys = Array.new
unit.keys.each do |key|
  unit_keys << key.to_i
end
unit_keys.sort!
highest_key = unit_keys[-1]

trooper_count = highest_key

# Line example:
# NR Gudrun Winter 25 AMM F 79BA55 GunCbt-1,Elec-1,Tactics-1 Innovator  7
input_file = File.read('fred4')
input_file.each do |line|
  line_array = line.split
  trooper_count += 1
  key = trooper_count.to_s
  puts "key is #{key}."
  unit[key] = Hash.new
  unit[key]['rank'] = line_array[0]
  unit[key]['first_name'] = line_array[1]
  unit[key]['last_name'] = line_array[2]
  unit[key]['age'] = line_array[3]
  unit[key]['political'] = line_array[4]
  unit[key]['gender'] = line_array[5]
  unit[key]['upp'] = line_array[6]
  unit[key]['skill_line'] = line_array[7]
  unit[key]['llp'] = line_array[8]
  unit[key]['morale'] = line_array[9]
  
  puts JSON.pretty_generate(unit[key])

end

out_file = File.open('blue_dragon_roster.json', 'w')
out_file.write(JSON.pretty_generate(unit))




