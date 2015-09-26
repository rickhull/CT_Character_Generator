#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
$DATA_PATH = File.expand_path("../../data", __FILE__)

require 'Traveller'
require 'character'
require 'Chargen'
require 'json'
require 'pp'

def valid_json?(json)
  begin 
    data = JSON.parse(json)
    return data, true
  rescue Exception => e
    return false
  end
end



data_file = "#{$DATA_PATH}/lot_of_chars.json"
if File.exists?(data_file)
  chars_in = File.read(data_file)
  chars = Hash.new
  chars, valid_json = valid_json?(chars_in)
end 

if valid_json
  careers = ['Mountainman', 'Warder', 'Path', 'Citizen', 'Guide' ]
  careers.each do |key|
    puts
    puts  "Looking at #{key} people."
    chars.each_key do |char|
      if chars[char]['career'] == key
        #puts "#{chars[char]['upp']} #{chars[char]['name']}"
        #puts "#{chars[char]['name']}"
        this_char = Hash.new
        this_char = chars[char]
        #puts this_char.inspect
        Traveller.write(this_char, 'txt')
      end
    end
  end
end
 
