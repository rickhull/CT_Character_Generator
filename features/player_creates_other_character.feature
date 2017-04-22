Feature: Player wants a Other character
  As a player
  I want to run Chargen -c Other
  So that I get a Other character

Scenario: create a Other character
  Given I need a Other character
  When  I run the program with a -c Other option
  Then  Output should have a Other career listed
