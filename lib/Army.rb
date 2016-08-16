# Template for new Careers. To create your own Career:

# 1. Change Mycareer to your career name. One word, and Ruby 
#     classes must begin with an uppercase Alpha character.
#
# 2. Change the skill_options array to use the list of skills
#     that don"t require Edu 8+. Look at existing skill lists
#     for the format. 
#    You can duplicate entries if a career should have a higher
#     instance of some skill. 
#
# 3. Change advanced_skill_options for skills requiring an Edu 8+
#     to get in CharGen.
#
# 4. Change values in muster_out["cash"] array.
#
# 5. Change values in muster_out["benefits"] array.
#
# 6. Change the rank method if the career has ranks. 
#     Add a commission roll as needed.
#     Add the names of the ranks. 
#     Recommended, but not required, to use terms as roll modifier.
#
# 7. Add the following stanza to the case statement in Chargen.rb:
#     when "Mycareer" then
#       require "Mycareer"
#       Mycareer.new(char)
#
# 8. Add "Mycareer" to the "available_careers" array in Chargen.rb.
#

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "CharacterTools"
require "Career"
require "Traveller"

class Army < Career 
  def initialize(char)
    @skill_options = [ 
      "Brawling",
      "+1 Str",
      "Gambling",
      "+1 Dex",
      "+1 End",
      "+1 End",
      "GunCbt",
      "+1 Soc",
      "+1 Soc",
      "HvyWpns",
      "Mechanical",
      "Tactics",
      "HvyWpns",
      "Mechanical",
      "Tactics",
      "Leader",
      "Leader",
      "Admin",
      "Instruction",
      "Admin",
      "FAGun",
      "Vehicle",
      "Mechanical",
      "FwdObs",
      "Computer",
      "Electronics",
      "Vehicle",
      "Vehicle",
      "Vehicle",
      "HvyWpns",
      "HvyWpns",
      "Mechanical",
      "Computer",
      "GunCbt",
      "GunCbt",
      "HvyWpns",
      "Vehicle",
      "Recon",
      "VaccSuit",
      "Vehicle",
      "CbtEng",
      "Vehicle",
      "Mechanical",
      "Electronic",
      "Medic",
      "Computer"
      ]
    @advanced_skill_options = [
      "BattleDress",
      "GunCbt",
      "GunCbt",
      "HvyWpns",
      "Demo",
      "Survival",
      "Recon",
      "+1 End",
      "GunCbt",
      "Vehicle",
      "HvyWpns",
      "Leader",
      "Tactics",
      "Tactics",
      "Leader",
      "Mechanic",
      "FwdObs",
      "Computer",
      "Electronics",
      "Medical",
      "Instruction",
      "Admin",
      "Admin",
      "FAGun",
      "Medic",
      "Computer",
      "Admin",
      "Liaison",
      "Leader",
      "JoT"
      ]

    @muster_out = Hash.new
    @muster_out["cash"] = [2000, 5000, 50000, 10000, 10000, 10000, 20000, 30000]
    @muster_out["benefits"] = [
      "LowPsg",
      "+1 Int",
      "+2 Edu",
      "Gun",
      "HighPsg",
      "MidPsg",
      "+1 Soc"
    ] 
    super(char) 
  end

  def rank(char)
    officers = %w[ 2LT 1LT CPT MAJ LTC COL BG MG LG GEN ]
    enlisted = %w[ PVT LCP CPL LSGT SGT LDSG 1SGT GSGT SMSG ]
    commission   = 5
    commission_roll  = Traveller.roll_dice(6,2,1) + char['terms'] - commission
    if commission_roll >= 0
      grade                   = [commission_roll/2 , officers.length - 1].min
      char['character'].rank = officers[grade]
    else
      grade                   = [char['terms'] + rand(2), enlisted.length - 1].min
      char['character'].rank  = enlisted[grade]
    end
  end

end

=begin
class Army < Character
  Grade = Hash.new
  Grade['Enlisted'] = %w(E1 E2 E3 E4 E5 E6 E7 E8 E9)
  Grade['Officer'] = %w(O1 O2 O3 O4 O5 O6)

  Ranks = { 
    'E1' => 'Private',
    'E2' => 'Lance Corporal',
    'E3' => 'Corporal',
    'E4' => 'Lance Sergeant',
    'E5' => 'Sergeant',
    'E6' => 'Leading Sergeant',
    'E7' => 'First Sergeant',
    'E8' => 'Gunnery Sergeant',
    'E9' => 'Sergeant Major',
    'O1' => 'Lieutenant',
    'O2' => 'Captain',
    'O3' => 'Force Commander',
    'O4' => 'Lieutenant Colonel',
    'O5' => 'Colonel',
    'O6' => 'Brigadier'
  }

  attr_accessor :rank

  def initialize()
    super
    @career = 'Army'
    @comission_roll = 9
    @grade_set = 'Enlisted'
    @officer = officer(@comission_roll)
    @rank = 'Private'
    @skills = { 'GunCbt' => 1 }
    @skill_options = [ 'Brawling', 'Gambling', '+1 Str', '+1 Dex', 'Medic', '+1 End', 'HeavyWpns', 'Vehicle', 'VaccSuit', 'Recon', 'GunCbt', 'GunCbt', 'Vehicle', 'Mechanical', 'Electronic', 'Tactics', 'Blade', 'GunCbt']
    @advanced_skill_options = ['Engineer', 'Demolition', 'Gunnery', 'Medical', 'Tactics', 'Electronic', 'Computer', 'Admin', 'Vehicle', 'Leader']
    @morale = morale
  end

  def set_rank()
    if @officer 
      grade_set = 'Officer'
      grade_level = [terms, 5].min
      min_stat('Edu', 6)
    else
      grade_set = 'Enlisted'
      grade_level = [terms + 1, 8].min
    end 
    grade = Grade[grade_set][grade_level]
    @rank = Ranks[grade]
  end

  def set_skills()
    rolls = terms + 1 

    edu = upp[4].chr.to_i(16)
    if edu >= 8
      @skill_options = @skill_options + @advanced_skill_options
    end

    if @officer
      increase_skill('GunCbt')
      rolls += 1
    end

    @morale += rolls
    rolls.times do
      new_skill = @skill_options[rand(@skill_options.count)]
      increase_skill(new_skill)
    end
    @title = Traveller.noble(@gender, @upp)
  end

end
=end
