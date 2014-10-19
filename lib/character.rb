class Character
  DEFAULT_AGE = 18
  STAT_NAMES = %w(Str Dex End Int Edu Soc)

  attr_accessor :career, :gender
  attr_writer :terms

  def initialize()
    @gender = ''
    @career = ''
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
    STAT_NAMES.inject('') do |upp, stat|
      upp + @stats[stat]
    end    
  end
end

