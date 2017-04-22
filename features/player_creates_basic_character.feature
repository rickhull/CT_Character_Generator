Feature: Player starts program
  As a player
  I want to run a command
  So that I get a character

Scenario: create basic character
  Given I need a character
  When  I run the program with a -b option
  Then  Output should have a six hex digit UPP
  And   Output age should be 18 or greater

