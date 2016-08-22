$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"

crew = ["Auger", "McCray", "Soler", "Chen", "Graves", "Grimes", "Petty", "Inglesias", "Cloarec", "Bradford", "Lejune"]

crew.each do |name|
  temp  = CharacterTools.temprament
  plot  = CharacterTools.plot
  puts "#{name}: #{temp}, #{plot}, #{rand(5) + 1}"
end

