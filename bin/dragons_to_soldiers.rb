#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
DATA_DIR = File.expand_path('../../data', __FILE__)

require 'json'
require 'Traveller'


def write_soldiers(data)
  soldier_file = File.open("#{DATA_DIR}/soldiers.json", 'w')
  soldier_file.write(JSON.pretty_generate(data))
  soldier_file.close
end

dragon_file = "#{DATA_DIR}/blue_dragon_roster.json"
if File.exists?(dragon_file)
  dragons_in = File.read(dragon_file)
  dragons = Hash.new
  dragons, valid_json = Traveller.valid_json?(dragons_in)
end

def skills_to_hash(soldier)
  unless soldier.has_key?('skills')
    soldier['skills'] = Hash.new
  end

  skill_array = soldier['skill_line'].split(',')
  skill_array.each do |skill|
    skill_name, skill_value = skill.split('-')
    soldier['skills'][skill_name] = skill_value.to_i
  end

  if soldier['skills'].has_key?('Tactics')
    soldier['morale_modifier'] += soldier['skills']['Tactics']
  end 
end

def terms(soldier)
  unless soldier.has_key?('terms')
    age = soldier['age'].to_i
    terms = (age - 18) / 4
    terms = [terms, 0].max
    puts "terms is #{terms}."
    soldier['terms'] = terms
  end
end

def add_awards(soldier)

  unless soldier.has_key?('awards')
    soldier['awards'] = Hash.new
  end

  award_list = %w[ CC CSR MCUF PH MCG SEH ]

  if soldier['awards'].has_key?('CSR')
    soldier['awards']['CSR'] += 1
  else
    soldier['awards']['CSR'] = 1
  end
  soldier['morale_modifier'] += 1

  leader_rank_list = %w[ LCP CPL SGT NCO LSG LT CPT ]
  if leader_rank_list.include?(soldier['rank'])
    if soldier['awards'].has_key?('CC')
      soldier['awards']['CC'] += 1
    else
      soldier['awards']['CC'] = 1
    end
  end
 
  wound_list = %w[ Light Serious Deadly ]
  if wound_list.include?(soldier['wound'])
    if soldier['awards'].has_key?('PH')
      soldier['awards']['PH'] += 1
    else
      soldier['awards']['PH'] = 1
    end
    soldier['morale_modifier'] += 1
  end

  # The Marine Raid Decoration roll is 5+
  decoration = ''
  decoration_roll = Traveller.roll_dice(6,2) - 4
  case decoration_roll
    when 1..3: 
      decoration = 'MCUF'
      soldier['morale_modifier'] += 1
    when 4..5: 
      decoration = 'MCG'
      soldier['morale_modifier'] += 2
    when > 5:
      decoration = 'SEH'
      soldier['morale_modifier'] += 3
  end
  puts "decoration_roll is #{decoration_roll}, for #{decoration}."
  
  unless decoration.length == 0
    if soldier['awards'].has_key?(decoration)
      soldier['awards'][decoration] += 1
    else
      soldier['awards'][decoration] = 1
    end
  end 

end

if valid_json
  soldiers = Hash[dragons]
  #puts "Found #{dragons.count} Dragons."
  #puts "Looking at Dragon 1."  
  #puts dragons['1'].inspect
 
  soldiers.each do |key, soldier|
    soldier['morale_modifier'] = 0
    terms(soldier)
    skills_to_hash(soldier)
    add_awards(soldier)
  end

  
  soldiers['1']['awards'] = { 'SEH' => 1, 'CSR' => 1}
  puts "Looking at Soldier 1."  
  soldiers['1']['awards'].each do |key, value|
    puts "#{key}: #{value}"
  end
  add_awards(soldiers['1'])
  puts "Added CSR."
  soldiers['1']['awards'].each do |key, value|
    puts "#{key}: #{value}"
  end
  puts "Morale Modifier: #{soldiers['1']['morale_modifier']}."
  puts "Terms: #{soldiers['1']['terms']}."
 
  write_soldiers(soldiers)
else
  puts "Kinda lost."
end




