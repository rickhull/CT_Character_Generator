# Base tool to create a quick NPC.
# ruby Chargen <-c career> <-t terms>
#   career defaults based on Soc and terms to 1-5.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "optparse"
require "Character"
require "CharacterTools"
require "Presenter"

# Default values for options.
career = ""
terms  = 0
available_careers = ["Marine", "Noble", "Citizen", "Other", "Navy"]

# Build the base character.
character = CharacterTools.init

# Parse the options.
options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on("-c career", "Career, defaults based on Soc") do |c| 
    career = c if available_careers.include?(c)
  end
  opts.on("-t terms", "Terms, defaults to range of 1-5") do |t|
    terms = t.to_i
  end
end
option_parser.parse!

# Stuff for testing method triggers.
#character.upp[5] = "F"
#character.upp[3] = "F"

# Set the options not provided.
career = CharacterTools.social_status(character) if career.empty?
srand && terms = rand(5) + 1 if terms == 0

# Set up the char hash to be passed around.
char = Hash.new(0)
char["character"] = character
char["career"]    = career
char["terms"]     = terms

# Modify the character's career.
CharacterTools.add_career(char)

# Run the character through the career.
case career 
  when "Marine" then
    require "Marine"
    Marine.new(char)
  when "Navy" then
    require "Navy"
    Navy.new(char)
  when "Noble" then
    require "Noble"
    Noble.new(char)
  when "Other" then
    require "Other"
    Other.new(char)
  else
    require "Citizen"
    Citizen.new(char)
end

# Just the output.
Presenter.show(character)
