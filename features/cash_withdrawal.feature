Feature: Cash withdrawal
  Scenario Outline: Successful withdrawal from an account in credit
    Given my account has been credited with $100
    When I withdraw $<wd>
    Then $<wd> should be dispensed
    And the balance of my account should be $<bal>

  Examples:
    | wd  | bal |
    | 20  | 80  |
    | 40  | 60  |
    | 60  | 40  |
    | 80  | 20  |
    | 100 | 0   |


  Scenario: Failed withdrawal from an account with insufficient funds
    Given my account has been credited with $50
    When I withdraw $100
    Then nothing should be dispensed
    And the balance of my account should be $50
