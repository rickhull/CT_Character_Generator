# This is the cumulative test suite for the entire
# CT_Character_Generator program. Test Cases will be 
# written for each component program and named
# "tc_<Program>.rb

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
$LOAD_PATH << File.expand_path("../../test", __FILE__)

require 'test/unit'
require 'tc_CharacterTools'
require 'tc_Traveller'
#require 'tc_Chargen'
#require 'tc_Career'
require 'tc_Citizen'
require 'tc_Navy'
require 'tc_Other'
require 'tc_Noble'
#require 'tc_PresenterDefault'
