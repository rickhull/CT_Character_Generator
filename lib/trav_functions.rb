# require 'lib/dice'

def roll2
  return 2 + rand(6) + rand(6)
end

def roll1
  return 1 + rand(6)
end

def average2
  return ((rand(6) + rand(6)) / 2) + 1
end

def hexconvert(num)
  return num.to_s(16).upcase
end

def make_stat
  return hexconvert(roll2)
end

def set_career
  careers = ['Navy', 'Army', 'Marine', 'Merchant', 'Scout']
  career = careers[rand(careers.length)]
  return career
end

def build_skills(career)
  skills = Hash.new
  skills['Army'] = ['CbtR', 'Drive', 'Ldr', 'CbtR', 'Mech', 'GunCbt', ]
  skills['Marine'] = ['CbtR', 'BattleDress', 'Ldr', 'CbtR', 'Mech', 'GunCbt', ]
  skills['Navy'] = ['Pilot', 'Nav', 'Sensors',]
  skills['Merchant'] = ['Pilot', 'Nav', 'Broker', 'Steward', 'Math']
  skills['Scout'] = ['Pilot', 'Nav', 'Sensors',]

  max = skills[career].length
  return skills[career][rand(max)]
end

def set_rank(branch, grade)
end

def stat_to_int(stat)
  return stat.to_i(10)
end

def get_stat_mod(stat)
  case
  when stat.to_i(16) < 6
    return -1
  when stat.to_i(16) > 9
    return 1
  else
    return 0
  end
end

#stats = {
#       'Str' => nil,
#       'Dex' => nil,
#       'End' => nil,
#       'Int' => nil,
#       'Edu' => nil,
#       'Soc' => nil
#       }

#stats_names = ['Str', 'Dex', 'End', 'Int', 'Edu', 'Soc']

#upp = ''

#stats.each_key do |stat|
#  stats[stat] = make_stat
#end

# age, terms, career = set_career

# skill_list = Hash.new
# terms.times do
#  new_skill = build_skills(career)
#  skill_list.[new_skill]=0
# end

# Output

#puts "." * 10

#stats_names.each do |stat|
#  upp = upp + stats[stat]
#end

#puts "UPP: #{upp}."
#puts "#{age} year old with #{terms} terms in the #{career}."

#skill_list.each do |skill|
#  puts skill
#end

# puts "." * 10

