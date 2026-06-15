Feature: Demoblaze add multiple products to cart
  As a shopper
  I want to add several products to the shopping cart
  So that I can buy more than one item at a time

  Background:
    Given I am on the Demoblaze home page
    And my shopping cart is empty

  @multiple_products_cart
  Scenario: Add several products to the cart
    When I add these products to the cart:
      | Product           |
      | Samsung galaxy s6 |
      | Nexus 6           |
    And I open the cart page
    Then I should see these products in the cart:
      | Product           |
      | Samsung galaxy s6 |
      | Nexus 6           |