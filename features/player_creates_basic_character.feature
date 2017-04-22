Feature: Player wants basic character
  As a player
  I want to run "Chargen -b"
  So that I get a basic character

Scenario: create basic character
  Given I need a basic character
  When  I run Chargen with a -b option
  Then  Output should have a six hex digit UPP
  And   Output age should be 18 or greater

