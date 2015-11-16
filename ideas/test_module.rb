#!/usr/bin/env ruby

module Marine
  def show_rank
    puts "I am a Marine!"
  end
end

module Pirate
  def show_rank
    puts "Arrgghhh!!"
  end
end

class Character
  include Marine
  include Pirate

  def set_career(career)
    puts career.instance_methods
    career.show_rank
  end
end

Fred = Character.new
Fred.set_career(Marine)

# Running this gets:
# show_rank
# ./test_module.rb:21:in `set_career': undefined method `show_rank' for Marine:Module (NoMethodError)
#   from ./test_module.rb:26


