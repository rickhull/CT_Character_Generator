#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'json'
require 'Trooper'
require 'optparse'

#roster_file = ''
toe_file = ''

troop_list = Hash.new

parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.banner = "Used to display a unit TO&E.
  Usage: #{program_name} -r <roster> -t <toe>"
  opts.on( '-r <roster file>', 'Which team member unit roster file?') do |roster|
    roster_file = roster
    character_file = File.read(roster)
    troop_list = JSON.parse(character_file)
  end
  opts.on('-t <to&e file>', 'Which organization table?') do |toe|
    toe_file = toe
  end
end
parser.parse!

#character_file = File.read(roster_file)
#troop_list = JSON.parse(character_file)

unit_file = File.read(toe_file)
unit_toe = JSON.parse(unit_file)

def team_as_text(designation, members, troop_list)
  ordinals = %w[ HQ 1st 2nd 3rd 4th 5th 6th 7th 8th 9th ]
  unit = Hash.new
  unit['designation'] = designation
  designation_array = designation.split('.')

  total_morale = 0
  unit_members = Array.new
  members.each do |member|
    unit_member = Trooper.new(troop_list[member])
    total_morale += unit_member.trooper_morale?.to_i
    unit_members << unit_member.trooper_text
  end
  unit_morale = total_morale.fdiv(members.count).round

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
  puts "#{title}  Morale:  #{unit_morale}"
  unit_members.each do |member|
    puts member
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

#<jhass> leitz: great. Note that we tend to leave get_ prefixes off in ruby and use foo? instead of is_foo
# Done.

#<jhass> leitz: to sum you can use .inject, unit["members"].inject(0) {|total, member| total + trooper_morale(member) }
# Not sure this is still feasible as I put the Trooper into it's own class.

#<jhass> a.fdiv(b) makes a nice replacement for a.to_f / b
# Done.

#<jhass> leitz: and you should use File.write/File.read or at least the block form of File.open, if you have a file.close somewhere you likely have a potential file handle leak ;)
