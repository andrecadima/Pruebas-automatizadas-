Feature: Demoblaze cart functionality
              As a demo user
              I want to add a product to the cart
  So that I can validate that the product is added correctly

        Background:
            Given I browse to Demoblaze page

        @demoblaze_add_product_to_cart
        Scenario: Add Nokia lumia 1520 to the cart
             When I click on the "Nokia lumia 1520" product
             Then the product detail page should be displayed for "Nokia lumia 1520"
             When I click on the Add to cart button
             Then the alert message should be "Product added"