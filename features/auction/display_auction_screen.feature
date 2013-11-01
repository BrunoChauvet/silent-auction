Feature: Display the auction screen
  In order to know what the heck is spinach
  As a developer
  I want it to behave in an expected way

  Scenario: Display the first 6 items
    Given the following items exist
      | Code | Name         | Start price |
      | 101  | Package 1    | 100         |
      | 102  | Package 2    | 100         |
      | 103  | Package 3    | 100         |
      | 104  | Package 4    | 100         |
      | 105  | Package 5    | 100         |
      | 106  | Package 6    | 100         |
    When I go to the auction page
    Then I should see the following items on the auction screen
      | Code | Name         | Price       |
      | 101  | Package 1    | 100         |
      | 102  | Package 2    | 100         |
      | 103  | Package 3    | 100         |
      | 104  | Package 4    | 100         |
      | 105  | Package 5    | 100         |
      | 106  | Package 6    | 100         |
