# This is the cumulative test suite for the entire
# CT_Character_Generator program. Test Cases will be 
# written for each component program and named
# "tc_<Program>.rb

require "test/unit"

# The infrastructure
#require "test/tc_character_tools"
#require "tc_dice"
#require "tc_name"
#require "tc_character"
#require "tc_Chargen"
#require "tc_Career"
#require "tc_PresenterDefault"

# The various careers
require_relative "tc_noble"
#require "tc_Other"
#require "tc_Citizen"
#require "tc_Firster"

#require "tc_Army"
#require "tc_Guide"
#require "tc_LEO"
#require "tc_Marine"
#require "tc_Merchant"
require_relative "tc_navy"
