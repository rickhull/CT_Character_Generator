require 'Character'
require 'Traveller'

10.times do
    person = Character.new
    upp = person.upp
    gender = person.gender
    skills = person.skills
    skills = Traveller.add_skill(skills, 'GunCbt', 1)
    person.skills = skills
    person.skills.each do |k,v|
      puts "#{k}-#{v}"
    end
    name = person.name
    puts "Hi, I'm #{name}, a #{gender} with a upp of #{upp}."
end

