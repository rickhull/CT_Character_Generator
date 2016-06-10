require 'Character'

10.times do
    person = Character.new
    upp = person.upp
    gender = person.gender
    name = person.name
    puts "Hi, I'm #{name}, a #{gender} with a upp of #{upp}."
end

