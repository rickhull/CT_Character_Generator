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

def print_mental()
  roll = rand(100)
  case roll
    when 0..6 then puts "Mover (action)"
    when 7..31 then puts "Doer (action)"
    when 32..44 then puts "Influencer (heart)"
    when 45..76 then puts "Responder (heart)"
    when 77..86 then puts "Shaper (head)"
    when 87..89 then puts "Producer (head)"
    when 90..99 then puts "Contemplator (head)"
  end
end

def out_txt(c)
  rank = c.rank
  name = c.name
  upp = c.upp
  gender = c.gender
  age = c.age
  terms = c.terms
  
  puts "#{c.career} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age}  #{terms} terms"
  first_skill = true
  c.skills.each do |skill, level|
    if first_skill == false
      print ", "
    end 
    print "#{skill}-#{level}"
    first_skill = false
  end
  puts""
end
