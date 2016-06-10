require 'lib/dice'

$dice = Dice.new

def roll2
  return $dice.roll2
end

def roll1
  return $dice.roll1
end

def average1
  return $dice.average1
end

def average2
  return $dice.average2
end

def out_txt(c)
  rank = c.rank
  name = c.name
  upp = c.upp
  gender = c.gender
  age = c.age
  terms = c.terms
  llp = c.llp
  
  puts "#{c.career} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age}  #{terms} terms"
  first_skill = true
  c.skills.each do |skill, level|
    if first_skill == false
      print ", "
    end 
    print "#{skill}-#{level}"
    first_skill = false
  end
  print "\n"
  puts llp
  puts""
end
