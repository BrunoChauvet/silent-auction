@javascript
Feature: Place a bid as an authenticated user

Background:
  Given the auction ends in 1 hour
  And the following items exist
    | Code | Name         | Start price | Increment |
    | 101  | Item 1       | 100         | 20        |
    | 102  | Item 2       | 200         | 50        |
  And the following users exist
    | Title | First name     | Last name   | Table   | Pin  |
    | Mr    | John           | Smith       | Table 1 | 1234 |
    | Mrs   | Amanda         | Smith       | Table 1 | 5678 |

  Scenario: Place a bid at start price
    Given I am authenticated
    When select the item "101 Item 1"
    Then I should see a bid price of "$100"
    When I submit the bid
    Then I should see the success message "Bid has been placed"
    And I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | $100        |
      | 102 Item 2       | $200        |

  Scenario: Place a bid at a higher price
    Given the following bids exist
      | Item   | Price  | User             |
      | 101    | 100    | Mrs Amanda Smith |
      | 102    | 200    | Mrs Amanda Smith |
    And I am authenticated
    When select the item "101 Item 1"
    Then I should see a bid price of "$120"
    When I submit the bid
    Then I should see the success message "Bid has been placed"
    Then I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | $120        |
      | 102 Item 2       | $200        |
    When select the item "102 Item 2"
    Then I should see a bid price of "$250"
    When I submit the bid
    Then I should see the success message "Bid has been placed"
    Then I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | $120        |
      | 102 Item 2       | $250        |

  Scenario: Bid is rejected when asked price is too low
    Given I am authenticated
    When select the item "101 Item 1"
    Then I should see a bid price of "$100"
    Given the following bids exist
      | Item   | Price  | User             |
      | 101    | 100    | Mrs Amanda Smith |
    When I submit the bid
    Then I should see the error message "Asked price is too low"
    When I cancel my bid
    Then I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | $100        |
      | 102 Item 2       | $200        |

  Scenario: Bid is rejected after auction has ended
    Given I am authenticated
    When select the item "101 Item 1"
    Then I should see a bid price of "$100"
    Given the auction has ended
    When I submit the bid
    Then I should see the error message "Auction has ended"
    When I cancel my bid
    And I should see the following bids
      | Item             | Price       |
      | 101 Item 1       | $100        |
      | 102 Item 2       | $200        |
