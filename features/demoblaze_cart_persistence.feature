Feature: Demoblaze cart persistence
  As a shopper
  I want products to remain in the cart
  So that I can continue shopping without losing items

  Background:
    Given I browse to Demoblaze page
    And I start with an empty Demoblaze cart

  @cart_persistence
  Scenario: Product remains in cart after navigating through the site
    When I add the product "Samsung galaxy s6"
    And I navigate back to the home page
    And I open the cart page
    Then the product "Samsung galaxy s6" should still be present in the cart