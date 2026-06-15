Feature: Demoblaze delete product from cart
  As a shopper
  I want to remove a product from the shopping cart
  So that I can correct my order before buying

  Background:
    Given I am on the Demoblaze home page
    And my shopping cart is empty

  @delete_product_from_cart
  Scenario: Remove Samsung galaxy s6 from the cart
    When I add the product "Samsung galaxy s6" to the cart
    And I open the cart page
    Then I see the product "Samsung galaxy s6" in the cart
    When I delete the product "Samsung galaxy s6" from the cart
    Then I should not see the product "Samsung galaxy s6" in the cart