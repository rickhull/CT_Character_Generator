#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
$DATA_PATH = File.expand_path("../../data", __FILE__)

require 'Traveller'
require 'Character'
require 'Presenter'
require 'json'

data_file = "#{$DATA_PATH}/soldiers.json"
if File.exists?(data_file)
  chars_in = File.read(data_file)
  chars = Hash.new
  chars, valid_json = Traveller.valid_json?(chars_in)
end 

if valid_json
  chars.each_key do |char|
    this_char = Character.new(chars[char])
    present_char = Presenter.new(this_char)
    present_char.show('txt')
  end
end
 
