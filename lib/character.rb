class Character
  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  attr_accessor :career, :gender, :name, :grade
  attr_writer :terms

  def initialize()
    @career = ''
    @gender = ''
    @grade = ''
    # @name = ''
    @stats = {}
  end

  def set_stat(stat, num)
    @stats[stat] = num
  end

  def get_stat(stat)
    @stats[stat]
  end

  def age
    @age ||= (terms * 4) + DEFAULT_AGE
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

