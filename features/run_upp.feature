Feature: user runs upp

  As a user I want to run the program and get a 6 hex digit string.

  Scenario: Base UPP
    Given nothing running
    When I run the program
    Then I get a 6 hex digit string



