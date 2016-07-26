
require 'optparse'

character = Hash.new(0)
character['upp'] = "777777"
character['gender'] = "female"
character['notes'] = Array.new
character['notes'] << "Big"
character['notes'] << "Smart"
character['careers'] = Hash.new(0)
character['careers'] = {"Noble" => 1, "Marine" => 2}

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


def edit_string(character, key)
  print "What value? "
  string = gets.chomp!
  character[key] = string
end

def get_index(character, key)
  index = 0
  character[key].each do |value|
    puts "   #{index}: #{value}"
    index += 1
  end
  print "Which index? "
  index = gets.chomp!
end

def get_mode
  puts "(a)dd, (e)dit, or (d)elete?"
  mode = gets.chomp!
end 

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
      puts "I'm not there yet."
      exit
  end
end

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
      puts "Sorry, not sure on that."
      exit
    end
end
 
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

print_character(character) if (options['print'] == true)
new_char = edit_character(character) if (options['edit'] == true)
print_character(new_char) if new_char

