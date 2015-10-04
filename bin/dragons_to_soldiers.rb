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
    soldier['terms'] = terms
  end
end

def add_awards(soldier)
  unless soldier.has_key?('awards')
    soldier['awards'] = Hash.new
  end

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
  if decoration_roll > 0
    case decoration_roll
      when 1..3: 
        decoration = 'MCUF'
        soldier['morale_modifier'] += 1
      when 4..5: 
        decoration = 'MCG'
        soldier['morale_modifier'] += 2
      else
        decoration = 'SEH'
        soldier['morale_modifier'] += 3
    end
   
    if soldier['awards'].has_key?(decoration)
      soldier['awards'][decoration] += 1
    else
      soldier['awards'][decoration] = 1
    end
  end 

end

def adjust_morale(soldier)
  soldier['morale'] = soldier['morale'].to_i
  #if soldier['morale'] < 7
  #  soldier['morale'] = 7
  #end
  soldier['morale'] += soldier['morale_modifier'].to_i
  soldier['morale_modifier'] = 0
end

def add_title(soldier)
  soldier['title'] = Traveller.noble?(soldier['gender'], soldier['upp'])
end

if valid_json
  soldiers = Hash[dragons]
 
  soldiers.each do |key, soldier|
    soldier['morale_modifier'] = 0
    terms(soldier)
    skills_to_hash(soldier)
    add_awards(soldier)
    add_title(soldier)

    # This should be last.
    adjust_morale(soldier)
  end

  
  puts "Looking at Soldier 1."  
  soldiers['1']['awards'].each do |key, value|
    puts "#{key}: #{value}"
  end
  puts "Morale Modifier: #{soldiers['1']['morale_modifier']}."
  puts "Morale: #{soldiers['1']['morale']}."
 
  write_soldiers(soldiers)

else
  puts "Kinda lost."
end
