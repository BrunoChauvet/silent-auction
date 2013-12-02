@javascript
Feature: Authenticate using PIN

  Scenario: Authenticate successfully
    Given the following users exist
      | Title | First name     | Last name   | Table   | Pin  |
      | Mr    | John           | Smith       | Table 1 | 1234 |
      | Mrs   | Amanda         | Smith       | Table 1 | 5678 |
    When I go to the authentication page
    And I select the table "Table 1"
    And I select the user "Mr John Smith"
    And I enter the pin "1234"
    Then I should see my bids page

  Scenario: Authentication error
    Given the following users exist
      | Title | First name     | Last name   | Table   | Pin  |
      | Mr    | John           | Smith       | Table 1 | 1234 |
      | Mrs   | Amanda         | Smith       | Table 1 | 5678 |
    When I go to the authentication page
    And I select the table "Table 1"
    And I select the user "Mr John Smith"
    And I enter the pin "0000"
    Then I should see the error message "Invalid pin"
