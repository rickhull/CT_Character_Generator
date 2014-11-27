$LOAD_PATH << File.expand_path("../lib", __FILE__)

require 'character'

class ImperialMarine < Character

  Ranks = Hash.new
  Ranks['Marine'] = { 
    'E1' => 'Private',
    'E2' => 'Lance Corporal',
    'E3' => 'Corporal',
    'E4' => 'Lance Sergeant',
    'E5' => 'Sergeant',
    'E6' => 'Leading Sergeant',
    'E7' => 'First Sergeant',
    'E8' => 'Sergeant Major',
    'O1' => 'Lieutenant',
    'O2' => 'Captain',
    'O3' => 'Force Commander',
    'O4' => 'Lieutenant Colonel',
    'O5' => 'Colonel',
    'O6' => 'Brigadier',
  }

  Comission_roll = 9


  attr_accessor :career

  def initialize()
    super
    @career = 'Marine'
  end

  def get_comission(roll)
    if roll >= Comission_roll
      comissioned = true
    end
  end  
end

