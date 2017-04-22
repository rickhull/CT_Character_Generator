Feature: Player wants a Navy character
  As a player
  I want to run Chargen -c Navy
  So that I get a Navy character

Scenario: create a Navy character
  Given I need a Navy character
  When  I run the program with a -c Navy option
  Then  Output should have a Navy career listed
