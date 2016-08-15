# Traveller implements game mechanisms for the 
# Traveller[https://en.wikipedia.org/wiki/Traveller_(role-playing_game)] 
# Role-Playing Game, copyright 
# {Far Future Enterprises}[http://farfuture.net]. 
# This code module is copyright {Leam Hall}[https://github.com/LeamHall], 
# and open for free fair use. Need a better license. 

module Traveller

  # Generic dice roller.
  def self.roll_dice(dice_type, dice_number, average_of = 1)
    total = 0.0 
    dice_number.times do
      average_total = 0
      average_of.times do
        average_total += rand(dice_type) + 1
      end
      total += (average_total / average_of).round 
    end
    return total.to_i
  end

  # Provides UPP as a 6 Hexidecimal character string.
  def self.upp
    upp = String.new
    6.times do
      stat = self.roll_dice(6,2,1)
      stat = stat.to_s(16).upcase
      upp  = upp + stat
    end
    return upp
  end

  # Returns gender in lowercase, "male" or "female". Even odds.
  def self.gender
    if self.roll_dice(6,1,1) >= 4
      return "male"
    else
      return "female"
    end
  end

  # Tests if the input is valid JSON, returns JSON parsed data and true. 
  def self.valid_json?(json)
    begin
      data = JSON.parse(json)
      return data, true
    rescue Exception => e
      return false
    end
  end
end
