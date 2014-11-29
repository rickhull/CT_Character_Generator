$LOAD_PATH << File.expand_path("../lib", __FILE__)

class Character
  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  attr_accessor :career, :gender, :name, :skills, :age
  attr_writer :terms

  def initialize()
    @career = ''
    @gender = ''
    @name = ''
    @stats = {}
    @skills = Hash.new
  end

  def set_name(gender='male')
    require 'sqlite3'
    begin
      db = SQLite3::Database.open "data/names.db"
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

  def increase_skill(skill, level=1)
    if @skills.has_key?(skill)
    then
      old_level = @skills[skill]
    else
      old_level = 0
    end
    @skills[skill] = old_level + level  
  end
 
  def set_stat(stat, num)
    @stats[stat] = num
  end

  def get_stat(stat)
    @stats[stat]
  end

  def age
    @age ||= (terms * 4) + DEFAULT_AGE + rand(3)
  end

  def terms
    @terms ||= 0
  end

  def upp
    if @stats.length == 0
      upp = ''
    else
      STAT_NAMES.inject('') do |upp, stat|
        upp + @stats[stat]
      end
    end    
  end

  def get_stat_modifier(upp_position, low, low_mod, high, high_mod)
    # Return the modifier based on high or low stat.
    stat = upp[upp_position, 1]
    stat = stat.to_i(16)
    if stat <= low
    then
      return low_mod
    elsif stat >= high
      return high_mod
    else
      return 0
    end
  end
  
end

