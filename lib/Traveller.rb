module Traveller

  def Traveller.roll_dice(dice_type, dice_number, average_of = 1)
    @total = 0.0 
    dice_number.times do
      @average_total = 0
      average_of.times do
        @average_total += rand(dice_type) + 1
      end
      @total += (@average_total / average_of).round 
    end
    return @total.to_i
  end

  def Traveller.noble?(gender, upp)
    nobility = Hash.new
    nobility['B'] = { 'f' => 'Dame',      'm' => 'Knight' }
    nobility['C'] = { 'f' => 'Baroness',  'm' => 'Baron' }
    nobility['D'] = { 'f' => 'Marquesa',  'm' => 'Marquis' }
    nobility['E'] = { 'f' => 'Countess',  'm' => 'Count' }
    nobility['F'] = { 'f' => 'Duchess',   'm' => 'Duke' }
 
    title = '' 
    soc = upp[5,1].upcase 
    if nobility.has_key?(soc)
      if gender.downcase == 'female'
        title = nobility[soc]['f']
      else
        title = nobility[soc]['m']
      end 
    end
    return title
  end 



end

    
