# Template for new Careers. To create your own Career:

# 1. Change Mycareer to your career name. One word, and Ruby 
#     classes must begin with an uppercase Alpha character.
#
# 2. Change the skill_options array to use the list of skills
#     that don't require Edu 8+. Look at existing skill lists
#     for the format. 
#    You can duplicate entries if a career should have a higher
#     instance of some skill. 
#
# 3. Change advanced_skill_options for skills requiring an Edu 8+
#     to get in CharGen.
#
# 4. Change values in muster_out['cash'] array.
#
# 5. Change values in muster_out['benefits'] array.
#
# 6. Change the rank method if the career has ranks. 
#     Add a commission roll as needed.
#     Add the names of the ranks. 
#     Recommended, but not required, to use terms as roll modifier.
#

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'CharacterTools'
require 'Career'
require 'Traveller'

class Navy < Career 
  def initialize(char)
    @skill_options = [ 
      "Brawling",
      '+1 Str',
      'Carouse', 
      "Gambling",
      '+1 End', 
      '+1 Dex',
      '+1 End', 
      '+1 Edu', 
      'Carouse', 
      "VaccSuit",
      "Gambling",
      '+1 Dex',
      'Blade', 
      'Brawling', 
      'GunCbt', 
      'Blade', 
      "Mechanical",
      'ShipsBoat', 
      "VaccSuit",
      "ZeroG",
      "Commo",
      "Admin",
      "JoT",
      'Carouse', 
      'Drive(any)',
      "FwdObs",
      "Survival",
      "VaccSuit",
      "BattleDress", 
      "VaccSuit",
      'GunCbt', 
      'Blade', 
      "Mechanical",
      'Leader',
      'Medic',
      "ZeroG",
      '+1 Edu', 
      "Instruction",
      "Admin",
      'Drive(any)', 
      '+1 End', 
      "GunCbt",
      "ShipsBoat",
      'Bribery', 
      '+1 Dex',
      "+1 Soc",
      'ShipsBoat', 
      'Drive(any)', 
      'Navigation', 
      'Engineering', 
      "Mechanical",
      "Electronics",
      "GunCbt",
      "Navigation",
      "Computer",
      "Liaison",
      "ZeroG",
      "VaccSuit",
      "Admin",
      "GunCbt",
      "Commo",
      "ShipsBoat",
      "Navigation",
      "Pilot",
      "FwdObs",
      "GunCbt",
      "Commo",
      "Computer",
      "Gunnery",
      "Mechanical",
      "Electronic",
      "Eng",
      "Mechanical",
      "VaccSuit",
      "Eng",
      "Eng",
      "Eng",
      "Admin",
      "JoT",
      "Electronic",
      "Admin",
      "Medical",
      "Computer",
      "Medical",
      "Medical",
      "Mechanical",
      "Mechanical",
      "Electronic",
      "Electronic",
      "Computer",
      "Computer",
      "Gravitics",
      "JoT",
      'Leader'
      ]
    @advanced_skill_options = [
      'Medic',
      'Computer',
      'Admin',
      'Liaison',
      'Leader',
      "Pilot",
      "ShipTactics",
      "Leader",
      "ShipTactics",
      "Computer",
      "Electronics",
      "GunCbt",
      "Admin",
      "Bribery",
      "ShipTactics",
      "FleetTactics",
      "+1 Int",
      "ShipTactics",
      "FleetTactics",
      'JoT'
      ]

    @muster_out = Hash.new
    @muster_out['cash'] = [1000, 5000, 5000, 10000, 20000, 50000, 50000]
    @muster_out['benefits'] = [
      'LowPsg',
      "+1 Int",
      "+1 Edu",
      "Blade",
      'TAS',
      'HighPsg',
      '+2 Soc'
    ] 
    super(char) 
  end

  def rank(char)
    officers = %w[ EN SLT LT LTCMDR CMDR CPT COMM FADM SADM GADM ]
    enlisted = %w[ SR SA AS PO3 PO2 PO1 CPO SCPO MCPO ]
    commission   = 10
    commission_roll  = Traveller.roll_dice(6,2,1) + char['terms'] - commission
    if commission_roll >= 0
      char['character'].rank = officers[commission_roll/2]
    else
      char['character'].rank = enlisted[char['terms'] + rand(2)]
    end
  end
end
