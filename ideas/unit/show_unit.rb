#!/usr/bin/env ruby

require 'json'

character_file = File.read('blue_dragon_roster.json')
troop_list = JSON.parse(character_file)

unit_file = File.read('blue_dragon_unit_toe.json')
unit_toe = JSON.parse(unit_file)

def show_trooper(trooper)
  %w[ rank first_name last_name morale ].each do |item|
    print "  #{trooper[item]} "
  end
  print "\n"
end

def get_trooper_morale(trooper)
  return trooper['morale']
end

def team_as_text(designation, members, troop_list)
  ordinals = %w[ HQ 1st 2nd 3rd 4th 5th 6th 7th 8th 9th ]
  unit = Hash.new
  unit['designation'] = designation
  designation_array = designation.split('.')
  unit['members'] = members
  total_morale = 0
  unit['members'].each do |member|
    total_morale += get_trooper_morale(troop_list[member]).to_i
  end
  unit_morale = total_morale.to_f / unit['members'].count
  unit['morale'] = unit_morale.round

  platoon = ordinals[designation_array[1].to_i]
  squad = ordinals[designation_array[2].to_i]
  team = ordinals[designation_array[3].to_i]

  if designation.end_with?('0.0.0')
    title = "Company Commander  "
  elsif designation.end_with?('0.1.0') || designation.end_with?('0.0')
    title = "#{platoon} Platoon Leader"
  elsif designation.end_with?('.0')
    ordinal = ordinals[designation_array[2].to_i]
    title = "#{platoon} Platoon #{squad} Squad Leader"
  else
    title = "#{platoon} Platoon #{squad} Squad #{team} Team"
  end
  puts "#{title}  Morale:  #{unit['morale']}"
  unit['members'].each do |member|
    show_trooper(troop_list[member])
  end  
  puts
end

%w[name type size].each do |header|
  print "#{unit_toe[header]} "
end
print "\n\n"

unit_toe['teams'].sort.each do |key, value|
  team_as_text(key, value, troop_list)
end

outfile = File.open('blue_dragon_unit_toe.json', 'w')
outfile.write(JSON.pretty_generate(unit_toe))
outfile.close

