Feature: Demoblaze cart total validation
  As a shopper
  I want to add multiple products to the cart
  So that I can check the total price is calculated correctly

  Background:
    Given I browse to Demoblaze page
    And I start with an empty Demoblaze cart

  @smoke @cart_total_validation
  Scenario: Validate cart total with multiple products
    When I add products with prices to the cart:
      | Product           | Price |
      | Samsung galaxy s6 | 360   |
      | Nexus 6           | 650   |
    And I open the cart page
    Then the cart total should be 1010