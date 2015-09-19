class Character

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  require 'Traveller'

  attr_accessor :career, :gender, :name, :skills, :age, :upp, :officer, :llp
  attr_writer :terms, :officer

  def initialize()
    @career = ''
    @gender = set_gender
    @name = set_name(@gender)
    @officer = false
    @stats = {}
    @skills = Hash.new
    @upp = Traveller.roll_upp
    @llp = set_llp()
  end

  def set_name(gender='male')
    require 'sqlite3'
    begin
      db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
      get_first_name = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
      first_name_result = get_first_name.execute

      get_last_name = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
      last_name_result = get_last_name.execute

      @name = "#{first_name_result.first} #{last_name_result.first}"
    rescue SQLite3::Exception => e
      abort(e)
    ensure
      get_first_name.close if get_first_name
      get_last_name.close if get_last_name
      db.close if db
    end
  end

  def increase_stat(stat, level=1)
    stat_index = STAT_NAMES.index(stat)
    amount = level[-1,1].to_i
    new_stat = @upp[stat_index,1].to_i(16) + amount
    new_stat = [new_stat, 15].min
    new_stat = new_stat.to_s(16).upcase
    @upp[stat_index] = new_stat
  end

  def max_stat(stat, max)
    stat_index = STAT_NAMES.index(stat)
    old_stat = @upp[stat_index,1].to_i(16)
    new_stat = [old_stat, max].min.to_s(16).upcase
    @upp[stat_index] = new_stat
  end

  def min_stat(stat, min)
    stat_index = STAT_NAMES.index(stat)
    old_stat = @upp[stat_index,1].to_i(16)
    new_stat = [old_stat, min].max.to_s(16).upcase
    @upp[stat_index] = new_stat
  end  

  def increase_skill(skill, level=1)
    if skill.split.length > 1
    then
      amount = skill.split[0]
      stat = skill.split[1]
      increase_stat(stat, amount)
    else
      if @skills.has_key?(skill)
      then
        old_level = @skills[skill]
      else
        old_level = 0
      end
      @skills[skill] = old_level + level
    end  
  end
 
  def set_gender
    gender_options = ['male', 'female']
    @gender ||= gender_options[rand(gender_options.length)]
    return @gender 
  end

  def age
    @age ||= (terms * 4) + DEFAULT_AGE + rand(3)
  end

  def terms
    @terms ||= 0
  end

  def officer(target_roll=13)
    @officer ||=  Traveller.roll_dice(6,2,1) >= target_roll
  end

  def set_llp()
    roll = Traveller.roll_dice(100,1,1)
    case roll
      when 1..6 then llp = 'Mover (action)'
      when 7..31 then llp = 'Doer (action)'
      when 32..44 then llp = 'Influencer (heart)'
      when 45..76 then llp = 'Responder (heart)'
      when 77..86 then llp = 'Shaper (head)'
      when 87..89 then llp = 'Producer (head)'
      when 90..100 then llp = 'Contemplator (head)'
    end
    return llp
  end

end

