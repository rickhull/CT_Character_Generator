$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require "Name"
options = { "species" => "humaniti", "gender" => "male"}
100.times do
    name = Name.new(options).to_s
    l_name = name.split
    puts l_name[1]
end
