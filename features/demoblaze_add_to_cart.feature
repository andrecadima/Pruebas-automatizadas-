Feature: Demoblaze add products to cart
  As a demo user
  I want to add products to the cart without logging in
  So that I can validate the add to cart functionality works for any user

  Background:
    Given I browse to Demoblaze page
    And I start with an empty Demoblaze cart

  @smoke @add_to_cart_single_product
  Scenario Outline: Add a single product to cart
    When I click on the "<product>" product
    Then the product detail page should be displayed for "<product>"
    When I click on the Add to cart button
    Then the alert message should be "Product added"

    Examples:
      | product |
      | Samsung galaxy s6 |
      | Nokia lumia 1520 |
      | Nexus 6 |
      | Iphone 6 32gb |
      | Sony xperia z5 |
      | HTC One M9 |