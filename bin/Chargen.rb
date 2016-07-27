# Base tool to create a quick NPC.
# ruby Chargen <-c career> <-t terms>
#   career defaults to "Citizen" and terms to 1-5.

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'optparse'
require 'Character'
require 'CharacterTools'
require 'Presenter'

# Default values for options.
career = ""
terms  = 0
available_careers = ['Marine', 'Navy', 'Noble', 'Citizen', 'Other']

# Build the base character.
character = CharacterTools.init

# Parse the options.
options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on('-c career', 'Career') do |c|
    career = c
  end
  opts.on('-t terms', 'Terms') do |t|
    terms = t.to_i
  end
end
option_parser.parse!

# Set the options not provided.

if career.empty?
  career = CharacterTools.social_status(character) 
end
srand && terms = rand(5) + 1 if terms == 0

# Modify the character
CharacterTools.add_career(character, career, terms)

# Just the output.
Presenter.show(character)
