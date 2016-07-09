module Traveller

##$DATA_DIR << File.expand_path("../../data", __FILE__)

  def Traveller.roll_dice(dice_type, dice_number, average_of = 1)
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

  def Traveller.upp
    upp = String.new
    6.times do
      stat = Traveller.roll_dice(6,2,1)
      stat = stat.to_s(16).upcase
      upp  = upp + stat
    end
    return upp
  end

  def Traveller.gender
    if Traveller.roll_dice(6,1,1) >= 4
      return 'male'
    else
      return 'female'
    end
  end

  def Traveller.first_name(gender='Male')
    require 'sqlite3'
    gender = gender.downcase
    begin 
      db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
      first_name_query = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
      first_name_result = first_name_query.execute
      first_name = first_name_result.first
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      first_name_query.close if first_name_query
      db.close if db
    end
    return first_name.to_s
  end

  def Traveller.last_name
    require 'sqlite3'
    begin 
      db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
      last_name_query = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
      last_name_result = last_name_query.execute
      last_name = last_name_result.first
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      last_name_query.close if last_name_query
      db.close if db
    end
    return last_name.to_s
  end

  def Traveller.name(gender)
    first_name  = Traveller.first_name(gender)
    last_name   = Traveller.last_name
    return "#{first_name} #{last_name}"
  end

  def Traveller.roll_upp
  # Same as Travller.upp, Phase out.
    @upp = ''
    6.times do
      @stat = Traveller.roll_dice(6,2,1)
      @stat = @stat.to_s(16).upcase
      @upp  = @upp + @stat
    end
    return @upp
  end
   
  def Traveller.valid_json?(json)
    begin
      data = JSON.parse(json)
      return data, true
    rescue Exception => e
      return false
    end
  end

  def Traveller.modify_stat(upp, index, difference)
    return upp if index > 5
    stat = upp[index, 1].to_i(16)
    new_stat = stat + difference
    new_stat = 0 if new_stat < 0
    new_stat = 15 if new_stat > 15
    upp[index] = new_stat.to_s(16).upcase
    return upp
  end

  def Traveller.add_skill(skills, skill, level=1)
    if skills.has_key?(skill)
      skills[skill] += level
    else
      skills[skill] = level
    end
    return skills 
  end

  def Traveller.set_stat(upp, index, number)
    upp[index,1] = number
    return upp 
  end

  def Traveller.noble?(upp)
    soc = upp[5,1].to_i(16)
    if soc >= 11
      return true
    else
      return false
    end
  end 


  def Traveller.noble(gender, upp)
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

  def Traveller.write(c, mode)
    rank = c.rank
    name = c.name
    upp = c.upp
    gender = c.gender
    age = c.age
    terms = c.terms
    llp = c.llp
    morale = c.morale
    career = c.career
    title = c.title
   
    if mode == 'txt' 
      puts "#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      first_skill = true
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts""
    elsif mode == 'hash'
      id = Hash.new
      id['name'] = name
      id['rank'] = rank
      id['upp'] = upp
      id['gender'] = gender
      id['age'] = age
      id['terms'] = terms
      id['llp'] = llp
      id['career'] = career
      id['morale'] = morale
      id['skills'] = c.skills
      id['title'] = title
      return id
    elsif mode == 'csv'
      print "#{career}:#{rank}:#{title}:#{name}:#{upp}:#{gender.capitalize}:#{age}:#{terms}:#{morale}:#{llp}:"
      c.skills.each do |skill,level|
        if first_skill == false
          print ","
        end
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts

    elsif mode == 'wiki'
      puts "#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      puts 
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts
      puts
    elsif mode == 'soldier'
      puts "#{rank} #{name} #{morale}"
    elsif mode == 'html'
      puts "<p>#{career} #{title} #{rank} #{name} #{upp} Gender #{gender.capitalize} Age #{age} Terms  #{terms} Morale #{morale} LLP #{llp}"
      print "<p>" 
      c.skills.each do |skill, level|
        if first_skill == false
          print ", "
        end 
        print "#{skill}-#{level}"
        first_skill = false
      end
      puts 
      puts "<br>"
    end

end

end
