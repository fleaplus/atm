Feature: Cash withdrawal
  Scenario: Successful withdrawal from an account in credit
    Given my account has been credited with $100
    When I withdraw $20
    Then $20 should be dispensed
    And the balance of my account should be $80

  Scenario: Failed withdrawal from an account with insufficient funds
    Given my account has been credited with $50
    When I withdraw $100
    Then $0 should be dispensed
    And the balance of my account should be $50
