@javascript
Feature: Place a bid for a particular user as a host

Background:
  Given the following items exist
    | Code | Name         | Start price | Increment |
    | 101  | Item 1       | 100         | 20        |
    | 102  | Item 2       | 200         | 50        |
  And the following users exist
    | Title | First name     | Last name   | Table   | Pin  |
    | Mr    | John           | Smith       | Table 1 | 1234 |
    | Mrs   | Amanda         | Smith       | Table 1 | 5678 |

  Scenario: Place a bid at start price
    Given I am authenticated as an admin
    When I select the table "Table 1"
    And I select the user "Mr John Smith"
    And I select the item "101 - Item 1" to place a guest bid
    Then I should see a bid price of "$100"
    When I submit the bid
    Then I should see the success message "Bid has been placed at $100"
