def has_json?(file)
  file_stuff = File.read(file)
  puts file if file_stuff.include?(json)
end

def new_dir(newdir, olddir)
  Dir.chdir(newdir)
  #Dir.foreach(dir) do |file|
  #  has_json?(file)
  puts Dir.getwd
  Dir.chdir(olddir)
  #end
end

Dir.foreach(".") do |file|
  next if file == '..' or file == '.'
  #puts "File #{file} is a file." if File.file?("../#{file}")
  #puts File.basename(file)
  #has_json?(file) if File.file?(file)
  puts file
  new_dir(file, Dir.getwd) if File.directory?(file) 
end
