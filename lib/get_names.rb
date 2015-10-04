#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

$DATA_PATH = File.expand_path("../../data", __FILE__)

def get_name(gender='male')
  require 'sqlite3'
  begin   
    db = SQLite3::Database.open "#{$DATA_PATH}/names.db"
    get_first_name = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
    first_name_result = get_first_name.execute

    get_last_name = db.prepare "SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1"
    last_name_result = get_last_name.execute

    @name = "#{first_name_result.first} #{last_name_result.first}"
    puts @name
  rescue SQLite3::Exception => e
    abort(e)
  ensure  
    get_first_name.close if get_first_name
    get_last_name.close if get_last_name
    db.close if db
  end
end

10.times do 
  get_name('female')
  get_name()
end

