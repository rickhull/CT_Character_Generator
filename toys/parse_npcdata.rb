#!/usr/bin/env ruby


npc_file      = File.open("npcdata.txt", "r")
out_file      = File.open("sorted_npcdata.csv", "w")
outlier_file  = File.open("outlier_npcdata.txt", "w")

rank      = ""
header    = ""
location  = ""
name      = ""

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

npc_file.each do |line|
  name      = ""
  gender    = nil
  rank      = nil
  location  = nil

  next if line.start_with?("Term")

  if groups.include?(line.strip!)
    header = line
    puts header
    next
  end

  line.split(" ").each do |item|
    case
      when locations.include?(item)
        location = item.gsub!(/\)/, '')
        location = item.gsub!(/\(/, '')
        has_location = true
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
      gender = "female"
    when item == "[M]", item == "(M)"
      gender = "male"
    when gender.nil?
      name = name + " " + item
  end
  end
  print "  "
  print "#{location} " unless location.nil?
  print "#{rank} " unless rank.nil?
  puts  "#{name} "
end


npc_file.close()
out_file.close()
outlier_file.close()
