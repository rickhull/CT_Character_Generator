# This is the cumulative test suite for the entire
# CT_Character_Generator program. Test Cases will be 
# written for each component program and named
# "tc_<Program>.rb

$LOAD_PATH << File.expand_path("../../lib/Careers", __FILE__)
$LOAD_PATH << File.expand_path("../../lib/Tools", __FILE__)
$LOAD_PATH << File.expand_path("../../test", __FILE__)

require "test/unit"

# The infrastructure
require "tc_CharacterTools"
require "tc_Dice"
require "tc_Name"
require "tc_Character"
#require "tc_Chargen"
#require "tc_Career"
#require "tc_PresenterDefault"

# The various careers
require "tc_Noble"
require "tc_Other"
require "tc_Citizen"
#require "tc_Firster"

#require "tc_Army"
#require "tc_Guide"
#require "tc_LEO"
#require "tc_Marine"
#require "tc_Merchant"
#require "tc_Navy"
