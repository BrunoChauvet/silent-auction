@javascript @wip
Feature: Authenticate using PIN

  Scenario: Display the first 6 items
    Given the following users exist
      | Title | First name     | Last name   | Table   | Pin  |
      | Mr    | John           | Smith       | Table 1 | 1234 |
      | Mrs   | Amanda         | Smith       | Table 1 | 5678 |
    When I go to the authentication page
    And I select the table "Table 1"
    And I select the user "Mr John SMith"
    And I enter the pin "1234"
    Then I should see my bids page
