# This lets you edit characters once they are created. 

$LOAD_PATH <<  File.expand_path("../../../lib", __FILE__)

require 'optparse'

character = Hash.new(0)
character['upp'] = "777777"
character['gender'] = "female"
character['notes'] = Array.new
character['notes'] << "Big"
character['notes'] << "Smart"
character['careers'] = Hash.new(0)
character['careers'] = {"Noble" => 1, "Marine" => 2}

# Print a character as is.
def print_character(character)
  puts "###"
  character.each_pair do |k,v|
    case character[k] 
      when String
        puts "#{k}: #{v}"
      when Array
        print "#{k.capitalize}:  "
        character[k].each { |v| print "#{v} " }
        puts
      when Hash
        character[k].each { |k,v| puts "  #{k}: #{v}" }
      else
        puts "Unknown in print_character"
    end
  end
  puts "###"
end


# Edit a string value.
def edit_string(character, key)
  print "What value? "
  string = gets.chomp!
  character[key] = string
end

# Show indices (?)
def get_index(character, key)
  index = 0
  character[key].each do |value|
    puts "   #{index}: #{value}"
    index += 1
  end
  print "Which index? "
  index = gets.chomp!
end

# What mode to operate in. 
def get_mode
  modes = ['a', 'e', 'd']
  puts "(a)dd, (e)dit, or (d)elete?"
  mode = gets.chomp!
  verbose_exit("Sorry, unknown mode.") unless modes.include?(mode) 
end 

# Exit with commentary.
def verbose_exit(exit_string)
  puts exit_string
  exit 
end

# Edit an array.
def edit_array(character, key)
  mode = get_mode
  case mode
    when "a"
      print "(a)dd value: "
      new_value = gets.chomp!
      character[key] << new_value  
    when "d"
      index = get_index(character, key).to_i
      character[key].delete_at(index)
    when "e"
      index = get_index(character, key).to_i
      puts "New text?"
      new_text = gets.chomp!
      character[key][index] = new_text
    else
      verbose_exit("Not sure how to do that to an array.")
  end
end

# Add an element to a datastore.
def add_element(character, key)
  puts "Add (a)rray, (h)ash, or (s)tring?"
  element_type = gets.chomp!
  case element_type
    when "a"
      character[key] = Array.new
    when "h"
      character[key] = Hash.new(0)
    when "s"
      character[key] = ""
    else
      verbose_exit("Not sure what element type that is.")
    end
end

# Edit a character 
def edit_character(character)
  key = ''
  puts "Current keys are: "
  character.each_key do |k|
    print "#{k} "
  end
  puts
  while key != 'q'
      print_character(character)
      puts "Enter 'q' to quit"
      print "Which key? "
      key = gets.chomp!
      return character if key == 'q'
      if character[key].instance_of? String
        edit_string(character, key)
      elsif character[key].instance_of? Hash
        edit_hash(character, key)
      elsif character[key].instance_of? Array
        edit_array(character, key)
      else
        add_element(character, key)
      end
      
  end
  print_character(character)
  return character
end


###### Main 


options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on('-p', '--print', 'Print') do |p|
    options['print'] = true
  end
  opts.on('-e', '--edit', 'Edit') do |k,v|
    options['edit'] = true
  end 
end
option_parser.parse!

continue = true

print_character(character) if (options['print'] == true)
while options['edit'] == true && continue != false
  new_char = edit_character(character) if (options['edit'] == true)
  print_character(new_char) if new_char
  print "(q)uit?"
  continue_key = gets.chomp!
  exit if continue_key == "q"
end

