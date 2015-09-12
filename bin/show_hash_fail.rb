#!/usr/bin/env ruby

require 'json'
require 'pp'

character_file = File.read('battle_results.json')
troop_list = JSON.parse(character_file)

def show_trooper(trooper)
  %w[ rank first_name last_name morale ].each do |item|
    print "#{trooper[item]} "
  end
  print "\n"
end

def get_trooper_morale(trooper)
  return trooper['morale']
end

#def make_unit(designation, members, troop_list)
def team_as_text(designation, members, troop_list)
  unit = Hash.new
  unit['designation'] = designation
  unit['members'] = members
  total_morale = 0
  unit['members'].each do |member|
    total_morale += get_trooper_morale(troop_list[member]).to_i
  end
  unit_morale = total_morale.to_f / unit['members'].count
  unit['morale'] = unit_morale.round

  puts "Unit: #{unit['desgination']}  Morale:  #{unit['morale']}"
  unit['members'].each do |member|
    show_trooper(troop_list[member])
  end  
end

#blue_dragons = Array.new
#blue_dragons[0] = Array.new
#blue_dragons[0][0] = Array.new
#blue_dragons[0][0][0] = Array.new
#blue_dragons[0][0][0][0] = Array.new
#blue_dragons[0][0][0][0] << %w[ 0.0.0.0 1,2,3,4 ]
#blue_dragons[0][0][0][1] << %w[ 0.0.0.1 1,2,3,4 ]

#pp blue_dragons
#Company = Struct.new(:platoons)
#Platoon = Struct.new(:squads)
#Squad = Struct.new(:teams)
#Team = Struct.new(:members)

#blue_dragons = Unit.new(1, 1, 1, [1,2,3,4])
#make_unit("1.1.1.1", %w[1 2 3 4 ], troop_list)

team_as_text("1.1.1.1", %w[1 2 3 4], troop_list)

#company.each do | _key, trooper|
#  show_trooper(trooper)
#end

