#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("./lib", __FILE__)

require 'json'
require 'Trooper'

unit_file = File.open('battle_results.txt')
unit = JSON.parse(unit_file)

this_trooper = Trooper(unit['0']).new
this_trooper.trooper_text



