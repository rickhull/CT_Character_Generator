$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'Traveller'
require 'CharacterTools'

# Need to ensure it can be an Fixnum
if ARGV[0]
  count = ARGV[0].to_i
else
  count = 10
end

if ARGV[1]
  career = ARGV[1]
else
  career = "Marine"
end

def basic_chargen
  upp     = Traveller.upp
  gender  =  Traveller.gender
  name    = Traveller.name(gender)
  return name, gender, upp
end

count.times do
  n,g,u = basic_chargen
  terms = rand(3)+1
  age   = 18 + (terms * 4) + rand(2)
  puts "#{n},#{g.capitalize},#{u},#{age},#{career},#{terms}"
end

