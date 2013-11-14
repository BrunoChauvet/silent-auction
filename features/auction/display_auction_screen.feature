@javascript
Feature: Display the auction screen

  Scenario: Display the first 6 items
    Given the following items exist
      | Code | Name         | Start price |
      | 101  | Package 1    | 100         |
      | 102  | Package 2    | 200         |
      | 103  | Package 3    | 250         |
      | 104  | Package 4    | 450         |
      | 105  | Package 5    | 220         |
      | 106  | Package 6    | 100         |
    When I go to the auction page
    Then I should see the following items on the auction screen
      | Code | Name         | Price       | Current bidder |
      | 101  | Package 1    | $100.00     | Start price    |
      | 102  | Package 2    | $200.00     | Start price    |
      | 103  | Package 3    | $250.00     | Start price    |
      | 104  | Package 4    | $450.00     | Start price    |
      | 105  | Package 5    | $220.00     | Start price    |
      | 106  | Package 6    | $100.00     | Start price    |
