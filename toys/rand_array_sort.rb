def rand_sort(orig, new)
  return new if orig.length == 0
  new << orig.delete_at(rand(orig.length - 1))
  rand_sort(orig,new)
end

orig = ["Rifle", "Blade", "HvyWpn", "JoT", "Recon", "SMG", "Tactics", "Admin", "AirRaft", "Brawl", "ZeroG", "Elec", "Gambling", "Gunnery", "Mechanical", "Medic", "Streetwise", "VaccSuit"]


new = Array.new

puts "Orig:"
puts orig
puts
rand_sort(orig, new)
puts "New:"
puts new
