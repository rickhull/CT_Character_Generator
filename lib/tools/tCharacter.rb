#module CharacterTools
#  def upp
#    return "7777"
#  end  
#end

class Character
require "CharacterTools"
include CharacterTools

  def my_upp
    @upp = upp
    return @upp
  end
end

mc = Character.new
u = mc.my_upp
puts u
