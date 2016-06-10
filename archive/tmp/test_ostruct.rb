#!/usr/bin/env ruby

require 'ostruct'
myhash = { "name" => "fred", "rank" => "sgt", "ceral" => 12345 }
data = OpenStruct.new(myhash)

p data

if data.respond_to?('name')
  puts data.name
end

