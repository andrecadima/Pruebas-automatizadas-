Feature: Demoblaze product detail validation
              As a demo user
              I want to open different product detail pages
  So that I can validate product information before adding items to the cart

        Background:
            Given I browse to Demoblaze page

        @product_detail_validation
        Scenario Outline: Validate product detail page information
             When I open the product detail page for "<product_name>"
             Then the product detail name should be "<product_name>"
              And the product detail price should contain "<product_price>"
              And the Add to cart button should be displayed

        Examples:
                  | product_name      | product_price |
                  | Samsung galaxy s6 | $360          |
                  | Nokia lumia 1520  | $820          |
                  | Nexus 6           | $650          |