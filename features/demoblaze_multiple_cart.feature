Feature: Demoblaze add multiple products to cart
              As a demo user
              I want to add multiple products to the cart
  So that I can validate that the cart stores more than one product correctly

        Background:
            Given I browse to Demoblaze page
              And I start with an empty Demoblaze cart

        @multiple_products_cart
        Scenario: Add multiple products to cart using data table
             When I add the following products to the cart:
                  | Product           |
                  | Samsung galaxy s6 |
                  | Nexus 6           |
              And I open the Demoblaze cart page
             Then the Demoblaze cart should contain these products:
                  | Product           |
                  | Samsung galaxy s6 |
                  | Nexus 6           |