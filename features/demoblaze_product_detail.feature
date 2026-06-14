Feature: Demoblaze product details
  As a shopper
  I want to view different product details
  So that I can check product information before buying

  Background:
    Given I browse to Demoblaze page

  @product_detail_validation
  Scenario Outline: View product details
    When I open the product detail page for "<product_name>"
    Then I see the product name "<product_name>"
    And I see the product price "<product_price>"
    And I see the "Add to cart" button

    Examples:
      | product_name      | product_price |
      | Samsung galaxy s6 | $360          |
      | Nokia lumia 1520  | $820          |
      | Nexus 6           | $650          |