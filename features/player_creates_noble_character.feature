Feature: Player wants a Noble character
  As a player
  I want to run Chargen -c Noble
  So that I get a Noble character

Scenario: create a Noble character
  Given I need a Noble character
  When  I run the program with a -c Noble option
  Then  Output should have a Noble career listed
