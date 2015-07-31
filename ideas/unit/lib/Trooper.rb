class Trooper

  def initialize(trooper)
    this_trooper = Hash.new
    this_trooper = trooper[1]
    @rank = this_trooper['rank']
    @first_name = this_trooper['first_name']
    @last_name = this_trooper['last_name']
    @morale = this_trooper['morale']
  end 

  def trooper_text()
    puts "#{@rank} #{@first_name} #{@last_name}  #{@morale}"
  end

end

