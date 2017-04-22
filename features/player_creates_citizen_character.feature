Feature: Player wants a Citizen character
  As a player
  I want to run Chargen -c Citizen
  So that I get a Citizen character

Scenario: create a Citizen character
  Given I need a Citizen character
  When  I run the program with a -c Citizen option
  Then  Output should have a Citizen career listed
