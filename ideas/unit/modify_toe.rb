#!/usr/bin/env ruby

require 'json'
require 'optparse'
require 'pp'

toe_file = ''

parser = OptionParser.new do |opts|
  program_name = File.basename($PROGRAM_NAME)
  opts.on('-t <to&e> file', '--toe', 'Provide a current TO&E file name.') do |toe|
    toe_file = toe
  end
end
parser.parse!

toe = JSON.parse(File.read(toe_file))

puts "So far you have:"
toe['teams'].sort.each do |key, value|
  print "#{key} : "
  value.each do |v| 
    print "#{v} "
  end
  puts
end 

end_entry = 'n'
until end_entry == 'y'

  puts "What key to add/modify? "
  key_to_mod = gets.chomp
  puts "Vaules for that key? "
  values_to_modify = gets.chomp

  toe['teams'][key_to_mod] = Array.new
  values_to_modify.split.each do |val|
    toe['teams'][key_to_mod] << val
  end

  puts "End entry? [Y/n]"
  end_entry = gets.chomp

end

out_file = File.open(toe_file, 'w')
out_file.write(JSON.pretty_generate(toe))
out_file.close

  



