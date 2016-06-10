#!/usr/bin/env ruby
#
# name:     character_store.rb
# version:  0.1.0
# date:     15 Jul 15
# author:   leam
# license:  "Use freely, don't blame me if it breaks."
# desc:     Stores characters, in JSON, for a game.


$LOAD_PATH << File.expand_path("./lib", __FILE__)

require 'Traveller'
require 'character'
require 'optparse'

# Data files are stored in data/<gamename>/json
DATADIR = 'data'

option = {}
parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.banner = "Used to store characters for a game.
  Usage: #{program_name} <command> <gamename>"

  opts.on('-a', '--add',
    'Add a character to the game.') do
    options[:task] = 'add'
  end

  opts.on('-l key value', '--like',
    'Find characters where an attribute equals a value.') do |key,value|
    options[:task] = 'search'
    options[:search_key] = key
    options[:search_value] = value
  end

  opts.on('-m character', '--modify',
    'Modify an existing character.') do |character|
    options[:task] = 'modify'
    options[:character] = character
  end

  opts.on('-g game', '--game', 
    'Choose the game file to use.') do |game|
    options[:game] = game
  end

  opts.on('-i variable', '--insert',
    'Add a variable to all characters in the game file.') do |variable|
    options[:task] = 'insert'
    options[:variable] = variable
  end

  opts.on('-s character', '--search',
    'Search for a character by name.') do |character|
    options[:task] = 'search'
    options[:character] = character
  end

end
parser.parse!


# The character's name is the key. 
# This could get tricky with UTF-16 names.

# process

# see if the gamefile exists.
#   if yes, open it into a hash
#   if no, create a new hash

  # possible errors:
  #   datadir not found
  #   file exists but not readable/json
  #   can't write to datadir
  #   can't write that file

# act on 'task'

# add
# Run through existing attributes.
# Set each one in turn.
# Yeah, slow and boring.

  # possible errors:
  #   Duplicate Character name.
  #   Improper value for key.
  #   Improper value type for key.

# insert
# Add a new key to all objects.

  # possible errors:
  #   Key already exists on some objects.
  #   Odd key name.
  #   Improper value type for key.

# like <key> <value>
# Print characters where <key> has <value>

  # possible errors:
  #   No such key.

# modify
# show current character
# show a <k>ey based selection to change. 

  # possible errors:
  #   Improper value for attribute.
  #   Improper value type for key.

# search <character>
# And do what?
# Should assume some output format.
# Default to text.

  # possible errors:
  #   That character doesn't exist.
  #   That character's hash key is some format.
  #   Requested output format not available.
