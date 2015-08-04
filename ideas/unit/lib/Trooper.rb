class Trooper

  def initialize(trooper)
#    this_trooper = Hash.new
#    this_trooper = trooper[1]
    @rank = trooper['rank']
    @first_name = trooper['first_name']
    @last_name = trooper['last_name']
    @morale = trooper['morale']
    @upp = trooper['upp']
    @skills = trooper['skill_line']
  end 

  def trooper_text
    return "#{@rank} #{@first_name} #{@last_name}  #{@upp} #{@skills} #{@morale}"
  end
  
  def trooper_morale?
    return @morale
  end

end

