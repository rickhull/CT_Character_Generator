
class Name

  $LOAD_PATH << File.expand_path("../../lib", __FILE__)
  $DATA_PATH = File.expand_path("../../data", __FILE__)

  attr_reader :name

  # Create a Character, with UPP, name, and gender.
  def initialize(options)
    @gender       ||= options["gender"]
    @species      ||= options["species"]
    @name         = name(@gender, @species)
    #return        @name
  end

  # Pulls a first name from the database, based on gender. 
  # Gender required but defaults to male.
  # Requires sqlite3 functionality and the database file.
  def first_name(gender="male", species="humaniti")
    require "sqlite3"
    gender    = gender.downcase
    species   = species.downcase
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
  def last_name(species)
    require "sqlite3"
    species   = species.downcase
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
  def name(gender, species)
    f_name   = first_name(gender,species)
    l_name    = last_name(species)
    return        "#{f_name} #{l_name}"
  end

  def to_s
    return @name
  end
end
