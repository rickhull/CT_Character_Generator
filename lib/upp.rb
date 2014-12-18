require 'dice'

class Upp

  def rollupp
    @upp = ''
    6.times do
      stat = rand(6) + rand(6) + 2
      stat = stat.to_s(16).upcase
      @upp = @upp + stat
    end 
  return @upp    
  end

end

