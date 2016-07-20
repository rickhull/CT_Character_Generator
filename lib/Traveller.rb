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
      return 'male'
    else
      return 'female'
    end
  end

  # Pulls a first name from the database, based on gender. 
  # Gender required but defaults to male.
  # Requires sqlite3 functionality and the database file.
  def self.first_name(gender='Male')
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

  # Pulls a last name from the database. In the future based on culture. 
  # Requires sqlite3 functionality and the database file.
  def self.last_name
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

  # Needs gender, produces first and last name as a single string.
  def self.name(gender)
    first_name  = self.first_name(gender)
    last_name   = self.last_name
    return "#{first_name} #{last_name}"
  end

  # Same as Travller.upp, Phase out.
  def self.roll_upp
    @upp = ''
    6.times do
      @stat = self.roll_dice(6,2,1)
      @stat = @stat.to_s(16).upcase
      @upp  = @upp + @stat
    end
    return @upp
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

  # Adjusts stat in UPP, needs UPP, stat index, and change difference.
  def self.modify_stat(upp, index, difference)
    return upp if index > 5
    stat = upp[index, 1].to_i(16)
    new_stat = stat + difference
    new_stat = 0 if new_stat < 0
    new_stat = 15 if new_stat > 15
    upp[index] = new_stat.to_s(16).upcase
    return upp
  end

  # Add a skill to the skills hash. 
  def self.add_skill(skills, skill, level=1)
    skills[skill] += level
    return skills 
  end

  # Set a stat to a specific value. 
  def self.set_stat(upp, index, number)
    upp[index,1] = number
    return upp 
  end

  # Return true if UPP is a Noble.
  def self.noble?(upp)
    soc = upp[5,1].to_i(16)
    if soc >= 11
      return true
    else
      return false
    end
  end 


  # Returns title if Character is a noble. Needs gender and UPP.
  def self.noble(gender, upp)
    nobility = Hash.new
    nobility['B'] = { 'f' => 'Dame',      'm' => 'Knight' }
    nobility['C'] = { 'f' => 'Baroness',  'm' => 'Baron' }
    nobility['D'] = { 'f' => 'Marquesa',  'm' => 'Marquis' }
    nobility['E'] = { 'f' => 'Countess',  'm' => 'Count' }
    nobility['F'] = { 'f' => 'Duchess',   'm' => 'Duke' }

    title = ""
    soc = upp[5,1].upcase 
    if nobility.has_key?(soc)
      if gender.downcase == "female"
        title = nobility[soc]['f']
      else
        title = nobility[soc]['m']
      end 
    end
    return title
  end 

# End of module
end
