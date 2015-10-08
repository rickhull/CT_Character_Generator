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

def sort_politics(soldier)
  case soldier['political']
    when 'A':   
      soldier['political']  = 'Citizen'
      soldier['career']     = 'Entertainer'
    when 'D':
      soldier['political']  = 'Domici'
      soldier['career']     = 'Marine'
    when 'G':
      soldier['political']  = 'Guide'
      soldier['career']     = 'Guide'
    when 'P':
      soldier['political']  = 'Guide'
      soldier['career']     = 'Path'
    when /MM$/:
      soldier['political']  = 'Mountain Man'
      soldier['career']     = 'Mountain Man'
    when 'R':
      soldier['political']  = 'Red Card'
      soldier['career']     = 'Warder'
    else
      soldier['political']  = 'Biter'
      soldier['career']     = 'Citizen'
  end
end
    
def add_politics(soldier)
  case soldier['career']
    when 'Army', 'Navy', 'Citizen', 'College', 'Entertainer':
      soldier['political']  = 'Biter'
    when 'Mountainman':
      soldier['political']  = 'Mountain Man'
      soldier['career']     = 'Mountain Man'
    when 'Guide', 'Path':
      soldier['political']  = 'Guide'
    when 'Warder':
      soldier['political']  = 'Red Card'
    else
      soldier['political']  = 'Biter'
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

def change_gender(soldier)
  if soldier['gender'] == 'female'
    soldier['gender'] = 'F'
  elsif soldier['gender'] == 'male'
    soldier['gender'] = 'M'
  end
end

def split_name(soldier)
  soldier['first_name'], soldier['last_name'] = soldier['name'].split
end

def fix_llp(soldier)
  case soldier['llp']
    when /^Contemplator/:
      soldier['llp']  = 'Contemplator'
    when /^Doer/:
      soldier['llp']  = 'Doer'
    when /^Encourager/:
      soldier['llp']  = 'Encourager'
    when /^Finisher/:
      soldier['llp']  = 'Finisher'
    when /^Influencer/:
      soldier['llp']  = 'Influencer'
    when /^Innovator/:
      soldier['llp']  = 'Innovator'
    when /^Leader/:
      soldier['llp']  = 'Leader'
    when /^Manager/:
      soldier['llp']  = 'Manager'
    when /^Mover/:
      soldier['llp']  = 'Mover'
    when /^Pleaser/:
      soldier['llp']  = 'Pleaser'
    when /^Producer/:
      soldier['llp']  = 'Producer'
    when /^Responder/:
      soldier['llp']  = 'Responder'
    when /^Scholar/:
      soldier['llp']  = 'Scholar'
    when /^Shaper/:
      soldier['llp']  = 'Shaper'
    else 
      puts "#{soldier['first_name']} #{soldier['last_name']}"
  end
end

def full_name(soldier)
  soldier['name'] = "#{soldier['first_name']} #{soldier['last_name']}"    
end

dragon_file = "#{DATA_DIR}/blue_dragon_roster.json"
if File.exists?(dragon_file)
  dragons_in = File.read(dragon_file)
  dragons = Hash.new
  dragons, blue_valid_json = Traveller.valid_json?(dragons_in)
end

if blue_valid_json
  soldiers = Hash[dragons]
 
  soldiers.each do |key, soldier|
    soldier['morale_modifier'] = 0
    terms(soldier)
    skills_to_hash(soldier)
    add_awards(soldier)
    add_title(soldier)
    sort_politics(soldier)
    fix_llp(soldier)
    full_name(soldier)
    # This should be last.
    adjust_morale(soldier)
  end
  dragon_count = soldiers.count
end

new_dragon_file = "#{DATA_DIR}/lot_of_chars.json"
if File.exists?(new_dragon_file)
  new_dragons_in = File.read(new_dragon_file)
  new_dragons = Hash.new
  new_dragons, new_valid_json = Traveller.valid_json?(new_dragons_in)
end

if new_valid_json
  new_dragons.each do |key, soldier|
    change_gender(soldier)
    add_politics(soldier)  
    fix_llp(soldier)
    split_name(soldier)
  end
   
end

soldiers.merge!(new_dragons)
write_soldiers(soldiers)
