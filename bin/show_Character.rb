$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'CharacterTools'
require 'Traveller'

10.times do
    person = CharacterTools.init
    upp = person.upp
    gender = person.gender
    name = person.name
    puts "Hi, I'm #{name}, a #{gender} with a upp of #{upp}."
    skills = person.skills
    skills = Traveller.add_skill(skills, 'GunCbt', 1)
    person.skills = skills
    person.skills.each do |k,v|
      puts "#{k}-#{v}"
    end
end

