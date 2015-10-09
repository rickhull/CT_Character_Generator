#!/bin/env ruby

# Adding DATA_DIR to separate code from input
DATA_DIR = File.expand_path('../../data', __FILE__)

requests = Hash.new
File.open("#{DATA_DIR}/keepers.txt") do |file|
  file.each_line do |line|
    if line.length < 20
      next
    end

    if line.split[3].length == 6
      upp = "#{line.split[3]}-#{line.split[1]}"
    elsif line.split[6].length == 6
      upp = "#{line.split[6]}-#{line.split[1]}"
    else
      puts "Can't understand #{line}."
    end

    if requests.has_key?(upp)
      requests[upp] << "#{line.split[1]} #{line.split[2]}"
    else
      requests[upp] = Array.new
      requests[upp] << "#{line.split[1]} #{line.split[2]}"
    end 
  end
end

# Adding output to show results.
requests.each do |key, value|
  #unless requests[key].length == 1
    print "Key:  #{key}  "
    value.each do |v|
      print "  #{v}"
    end
    puts
  #end
end
