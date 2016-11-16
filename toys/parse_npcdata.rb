#!/usr/bin/env ruby


npc_file      = File.open("npcdata.txt", "r")
out_file      = File.open("sorted_npcdata.csv", "w")
outlier_file  = File.open("outlier_npcdata.txt", "w")

rank      = ""
header    = ""
location  = ""
name      = ""
age       = ""
yob       = ""
psr       = ""

locations = ["(core)", "(convoy)", "(Oregrund)"]
ranks = ["1SGT", "Captain", "'Captain", "(Captain)", "Cpl.", "CPL", "Corporal", "L.Cpl.", "LCPL", "Lt.", "Lieutenant", "(Lieutenant)", "Pvt."]
groups = [
  "The Domici:",
  "BDCR - South",
  "Flying Boat:",
  "Hofud Marines:",
  "Communication - Lot 2:",
  "Mikael's Diner - Lot 7:",
  "Gunship Landing Pad - Lot 8:",
  "Great House/Medical Clinic - Lot 9:",
  "Inn - Lot 10:",
  "Market - Lot 11:",
  "Salvage - Lot 13:",
  "Garage - Lot 14:",
  "Construction - Lot 15:",
  "Nana's Family:",
  "Lou's Family:",
  "Jeremy's Family:",
  "Debara's Family:",
  "Jerry's Family:"
  ]

oddstarts = ["Term", "\.\.\. ", "Ally", "5", "frequent "]

npc_file.each do |line|
  name      = ""
  gender    = nil
  rank      = nil
  location  = nil
  psr       = nil

  if line.length < 2
    next
  end

  starter = line[0..3]
  if oddstarts.include?(starter) 
    outlier_file.puts line  
    next
  end

  if groups.include?(line.strip!)
    header = line
    out_file.puts
    out_file.puts header
    next
  end

  line.split(" ").each do |item|
    case
      when locations.include?(item)
        location = item.gsub!(/\)/, '')
        location = item.gsub!(/\(/, '')
      when ranks.include?(item)
        case item
          when "Captain"      : rank = "CPT"
          when "'Captain"     : rank = "CPT"
          when "(Captain)"    : rank = "CPT"
          when "Cpl."         : rank = "CPL"
          when "Corporal"     : rank = "CPL"
          when "L.Cpl."       : rank = "LCPL"
          when "Lieutenant"   : rank = "LT"
          when "Lt."          : rank = "LT"
          when "(Lieutenant)" : rank = "LT"
          when "Pvt."         : rank = "PVT"
          else rank = item
        end
    when item == "[F]", item == "(F)"
      gender = "F"
    when item == "[M]", item == "(M)"
      gender = "M"
    when gender.nil?
      name = name + " " + item
    when item.match(/\A[0-9].\)/)
      item.gsub!(/\)/, '')
      item.gsub!(/\:/, '')
      age = item.to_i
      yob = 1416 - age 
    when item.match(/\(PSR=[0-9A-F]./)
      item.gsub!(/\)/, '')
      item.gsub!(/\(PSR=/, '')
      psr = item.to_i
    end

  end

  # Setting baseline.
  location = "Nowhere" if location.nil?
  name.strip!
 
  string  = "   "
  string += "#{rank} " unless rank.nil?
  string += "#{name} "
  string += "[#{gender}] "
  string += "[#{age}/IC-#{yob}] "
  string += "[PSR=#{psr}] " unless psr.nil?
  string += "(Currently at: #{location}) "
  out_file.puts string
end


npc_file.close()
out_file.close()
outlier_file.close()
