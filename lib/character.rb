class Character
  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  attr_accessor :career, :gender, :name, :stat_mods, :grade, :upp
  attr_writer :terms

  def initialize()
    @gender = ''
    @career = ''
    @stats = {}
    @stat_mods = {}
    @grade = ''
    @upp = ''
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

  def set_stat_mods
    STAT_NAMES.each do |stat|
      @stat_mods[stat] = get_stat_mod(@stats[stat])
    end
  end

  def show_stat_mods
    STAT_NAMES.each do |stat|
      puts "#{stat} modifier is #{@stat_mods[stat]}."
    end
  end
 
end

