
Feature:  the DM wants a new character

  The DM runs the program with a career option. 
  The resulting character fits the CT LBB parameters for that career.

  Scenario: Request a Marine
    Given nothing running
    When I use the "--marine" option
    Then the character is labelled as a Marine
