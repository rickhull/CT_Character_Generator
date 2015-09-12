#!/usr/bin/env ruby
# *-* coding: utf8 *-*

$LOAD_PATH << File.expand_path('../lib', __FILE__)

# vehicle.rb

require 'json'
require 'pp'
require 'optparse'

vehicles = Hash.new
vehicle_file = '../data/vehicles.json'
read_vehicle_file = false
show = false
add = false
show_format = 'text'
formats = ['text', 'html', 'wiki']

def valid_json?(json)
  begin 
    data = JSON.parse(json)
    return data, true
  rescue Exception => e
    return false
  end
end

def add_vehicle(vehicles)
  continue = 'y'
  until continue != 'y'
    puts "Sample vehicle:"
    puts "Designation:  TL14AR"
    puts "Type: Airraft"
    puts "Tech Level: 14"
    puts "Crew Required: 1"
    puts "Movement Type:  Grav"
    puts "Movement Speed: 180 kph"
    puts "Armor (top, bottom, front, rear, sides):  0 20 20 20 20"
    puts "Weapons:  FGMP-14"
    puts "Notes:  Appears as TL 10 air raft."

    puts

    print "Designation: "
    designation = gets.chomp

    vehicles[designation] = Hash.new

    print "Type:   "
    vehicles[designation]['type'] = gets.chomp

    print "Tech Level:  "
    vehicles[designation]['tl']  = gets.chomp

    print "Crew Required: "
    vehicles[designation]['crew'] = gets.chomp

    print "Movement Type: "
    vehicles[designation]['move_type'] = gets.chomp

    print "Max Speed: "
    vehicles[designation]['max_speed'] = gets.chomp

    print "Armor (top bottom front rear sides): "
    vehicles[designation]['armor'] = gets.chomp

    print "Weapons: "
    vehicles[designation]['weapons'] = gets.chomp

    print "Cargo Capacity (dtons):  "
    vehicles[designation]['cargo'] = gets.chomp

    print "Passengers (Normal/Max): "
    vehicles[designation]['passengers'] = gets.chomp

    print "Notes: "
    vehicles[designation]['notes'] = gets.chomp

    puts "Continue? [y/n]"
    continue = gets.chomp
  end
end

def show_vehicles(vehicles, format = 'text')
  vehicle_headers = Hash.new
  vehicle_headers['designation'] = 'Designation'
  vehicle_headers['type'] = 'Type'
  vehicle_headers['tl'] = 'Tech Level'
  vehicle_headers['move_type'] = 'Move Type'
  vehicle_headers['max_speed'] = 'Max Speed'
  vehicle_headers['armor'] = 'Armor (Top,Bottom,Front,Rear,Sides)'
  vehicle_headers['weapons'] = 'Weapons'
  vehicle_headers['cargo'] = 'Cargo Capacity (dtons)'
  vehicle_headers['passengers'] = 'Passengers (Normal/Max)'
  vehicle_headers['notes'] = 'Notes'

  header_array = %w(designation type tl move_type max_speed armor weapons cargo passengers notes)

  vehicles.keys.each do |designation|
    header_array.each do |header|
      header_title = vehicle_headers[header]
      value = vehicles[designation][header]
      #puts "value is #{value}."
      #puts "header_title is #{header_title}."
      if header_title == 'Designation'
        value = designation
      end
      #if value.is_a? String
        print "''' " if format == 'wiki'
        print "#{header_title} :"
        print " ''' " if format == 'wiki'
        print " #{value}"
        puts if format == 'wiki'
        puts
      #end
    end
  puts
  end
end

  
parser = OptionParser.new do |opts|
  
  opts.on('-f <vehicle_file>','Vehicle info file') do |file|
    if File.exists?(file)
      vehicle_file = file
      vehicles = Hash.new
      vehicles_in = File.read(vehicle_file)
      vehicles, valid_json = valid_json?(vehicles_in)
      unless valid_json
        vehicles = Hash.new
        vehicle_file = file
        File.open(vehicle_file, 'w') {}
      end
      read_vehicle_file = true
    end
  end
  opts.on('-s [format]', 'Show vehicles') do |format|
    show = true
    add = false
    if formats.include?(format)
      show_format = format
    end
  end
  opts.on('-a', 'Add vehicles') do
    show = false
    add = true
  end 
end


parser.parse!

unless read_vehicle_file
  vehicles_in = File.read(vehicle_file)
  vehicles, valid_json = valid_json?(vehicles_in)
  unless valid_json
    puts "Cannot read #{vehicle_file}, exiting."
    exit
  end
end

if add 
  add_vehicle(vehicles)
end

if show
  show_vehicles(vehicles, show_format)
end
 
if vehicles.count > 0 
  outfile = File.open(vehicle_file, 'w')
  outfile.write(JSON.pretty_generate(vehicles)) 
end
 
    
