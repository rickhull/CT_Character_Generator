if ARGV[1].nil?
  puts "Need 2 numbers" 
  exit
end

first   = ARGV[0].to_i
second  = ARGV[1].to_i
srand()
f_times = 0

first.times do
  f_times += 1
  s_times = 0
  second.times do
    s_times += 1
    roll = rand(6) + rand(6) + 2
    roll = "x" if s_times == f_times
    printf("%3s ", roll)
  end
  puts
end

