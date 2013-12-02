@javascript @wip
Feature: Place a bid as an authenticated user

  Scenario: Authenticate successfully
    Given the following items exist
      | Code | Name         | Start price |
      | 101  | Item 1       | 100         |
      | 102  | Item 2       | 200         |
    And I am authenticated
    When select the item "101"
    Then I should see a bid price of "$100"
    When I submit the bid
    Then I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | 100         |
      | 102 Item 2       | 200         |
