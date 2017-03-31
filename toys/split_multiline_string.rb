my_output = "Kim Christiansen Male Age: 18 B986B8 
Curly medium brown short hair brown skin 
Promoter Involuntary crimes of love 

"
puts my_output.length
my_output_array = my_output.split("\n")
puts my_output_array.length

index = 0
my_indexed_output = []

my_output_array.each do |line|
  my_indexed_output[index] = line.split()
  index += 1
end
puts my_indexed_output[2].length
